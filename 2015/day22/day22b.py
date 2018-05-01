import sys
from copy import deepcopy

BOSS_HIT_POINTS = 71
BOSS_DAMAGE = 10

PLAYER_HIT_POINTS = 50
PLAYER_MANA = 500

MAGIC_MISSILE_COST = 53
MAGIC_MISSILE_DAMAGE = 4
DRAIN_COST = 73
DRAIN_DAMAGE = 2
SHIELD_COST = 113
SHIELD_ARMOR = 7
SHIELD_TURNS = 6
POISON_COST = 173
POISON_DAMAGE = 3
POISON_TURNS = 6
RECHARGE_COST = 229
RECHARGE_MANA = 101
RECHARGE_TURNS = 5

least_mana_used = 999999999999

class Player:
    def __init__(self):
        self.mana = PLAYER_MANA
        self.hit_points = PLAYER_HIT_POINTS
        self.shield = 0
        self.poison = 0
        self.recharge = 0
        self.mana_spent = 0
        self.armor = 0
        self.damage = 0
        self.spells = []

    def cast_magic_missile(self):
        if self.mana < MAGIC_MISSILE_COST:
            return False
        self.mana -= MAGIC_MISSILE_COST
        self.mana_spent += MAGIC_MISSILE_COST
        self.spells.append("MM")
        return True

    def cast_drain(self):
        if self.mana < DRAIN_COST:
            return False
        self.mana -= DRAIN_COST
        self.hit_points += DRAIN_DAMAGE
        self.mana_spent += DRAIN_COST
        self.spells.append("drain")
        return True

    def cast_shield(self):
        if self.mana < SHIELD_COST:
            return False
        if self.shield != 0:
            return False
        self.mana -= SHIELD_COST
        self.shield = SHIELD_TURNS
        self.mana_spent += SHIELD_COST
        self.spells.append("shield")
        return True

    def cast_poison(self):
        if self.mana < POISON_COST:
            return False
        if self.poison != 0:
            return False
        self.mana -= POISON_COST
        self.poison = POISON_TURNS
        self.mana_spent += POISON_COST
        self.spells.append("poison")
        return True

    def cast_recharge(self):
        if self.mana < RECHARGE_COST:
            return False
        if self.recharge != 0:
            return False
        self.mana -= RECHARGE_COST
        self.recharge = RECHARGE_TURNS
        self.mana_spent += RECHARGE_COST
        self.spells.append("recharge")
        return True

    def next_turn(self):
        if self.shield > 0:
            self.armor = SHIELD_ARMOR
            self.shield -= 1
        else:
            self.armor = 0
        if self.poison > 0:
            self.damage = POISON_DAMAGE
            self.poison -= 1
        else:
            self.damage = 0
        if self.recharge > 0:
            self.recharge -= 1
            self.mana += RECHARGE_MANA

    def take_damage(self, damage):
        damage -= self.armor
        self.hit_points -= damage

    def do_damage(self):
        return self.damage

def update_least_mana_spent(player):
    global least_mana_used
    if player.mana_spent < least_mana_used:
        least_mana_used = player.mana_spent

def next_turn_go(player, boss_hit_points):
    player.next_turn()
    damage_to_boss = player.do_damage()
    return boss_hit_points - damage_to_boss

def battle_to_death(boss_hit_points, player):
    global least_mana_used
    player.hit_points = player.hit_points - 1
    if player.hit_points <= 0:
        return
    if boss_hit_points <= 0:
        update_least_mana_spent(player)
        return
    if player.mana < MAGIC_MISSILE_COST:
        return

    # Magic Missile
    magic_missile_player = deepcopy(player)
    boss_hit_points_copy = boss_hit_points
    if magic_missile_player.cast_magic_missile():
        boss_hit_points_copy -= MAGIC_MISSILE_DAMAGE
        if boss_hit_points_copy <= 0:
            update_least_mana_spent(magic_missile_player)
            return
        boss_hit_points_copy = next_turn_go(magic_missile_player, boss_hit_points_copy)
        if boss_hit_points_copy <= 0:
            update_least_mana_spent(magic_missile_player)
            return
        magic_missile_player.take_damage(BOSS_DAMAGE)
        if magic_missile_player.hit_points <= 0:
            return
        boss_hit_points_copy = next_turn_go(magic_missile_player, boss_hit_points_copy)
        battle_to_death(boss_hit_points_copy, magic_missile_player)

    # Drain
    drain_player = deepcopy(player)
    boss_hit_points_copy = boss_hit_points
    if drain_player.cast_drain():
        boss_hit_points_copy -= DRAIN_DAMAGE
        if boss_hit_points_copy <= 0:
            update_least_mana_spent(drain_player)
            return
        boss_hit_points_copy = next_turn_go(drain_player, boss_hit_points_copy)
        if boss_hit_points_copy <= 0:
            update_least_mana_spent(drain_player)
            return
        drain_player.take_damage(BOSS_DAMAGE)
        if drain_player.hit_points <= 0:
            return
        boss_hit_points_copy = next_turn_go(drain_player, boss_hit_points_copy)
        battle_to_death(boss_hit_points_copy, drain_player)

    # Shield
    shield_player = deepcopy(player)
    boss_hit_points_copy = boss_hit_points
    if shield_player.cast_shield():
        boss_hit_points_copy = next_turn_go(shield_player, boss_hit_points_copy)
        if boss_hit_points_copy <= 0:
            update_least_mana_spent(shield_player)
            return
        shield_player.take_damage(BOSS_DAMAGE)
        if shield_player.hit_points <= 0:
            return
        boss_hit_points_copy = next_turn_go(shield_player, boss_hit_points_copy)
        battle_to_death(boss_hit_points_copy, shield_player)

    # Poison
    poison_player = deepcopy(player)
    boss_hit_points_copy = boss_hit_points
    if poison_player.cast_poison():
        boss_hit_points_copy = next_turn_go(poison_player, boss_hit_points_copy)
        if boss_hit_points_copy <= 0:
            update_least_mana_spent(poison_player)
            return
        poison_player.take_damage(BOSS_DAMAGE)
        if poison_player.hit_points <= 0:
            return
        boss_hit_points_copy = next_turn_go(poison_player, boss_hit_points_copy)
        battle_to_death(boss_hit_points_copy, poison_player)

    # Recharge
    recharge_player = deepcopy(player)
    boss_hit_points_copy = boss_hit_points
    if recharge_player.cast_recharge():
        boss_hit_points_copy = next_turn_go(recharge_player, boss_hit_points_copy)
        if boss_hit_points_copy <= 0:
            update_least_mana_spent(recharge_player)
            return
        recharge_player.take_damage(BOSS_DAMAGE)
        if recharge_player.hit_points <= 0:
            return
        boss_hit_points_copy = next_turn_go(recharge_player, boss_hit_points_copy)
        battle_to_death(boss_hit_points_copy, recharge_player)

battle_to_death(BOSS_HIT_POINTS, Player())

print(least_mana_used)
