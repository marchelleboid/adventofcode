from math import ceil

BOSS_HIT_POINTS = 100
BOSS_DAMAGE = 8
BOSS_ARMOR = 2

PLAYER_HIT_POINTS = 100

weapons = [(8,4), (10,5), (25,6), (40,7), (74,8)]
armors = [(13,1), (31,2), (53,3), (75,4), (102,5)]
rings = [(25,1,0), (50,2,0), (100,3,0), (20,0,1), (40,0,2), (80,0,3)]

def does_player_win_battle(damage, armor):
    player_effective_damage = damage - BOSS_ARMOR
    if player_effective_damage <= 0:
        return False
    boss_effective_damage = BOSS_DAMAGE - armor
    if boss_effective_damage <= 0:
        return True
    player_turns_to_win = ceil(BOSS_HIT_POINTS/player_effective_damage)
    boss_turns_to_win = ceil(PLAYER_HIT_POINTS/boss_effective_damage)
    return player_turns_to_win <= boss_turns_to_win

most_gold = 0

for weapon in weapons:
    cost = weapon[0]
    damage = weapon[1]
    armor = 0
    for x in range(0, len(armors) + 1):
        if x != len(armors):
            cost += armors[x][0]
            armor += armors[x][1]

        # No rings
        if not does_player_win_battle(damage, armor):
            if cost > most_gold:
                most_gold = cost

        for y in range(0, len(rings)):
            ring1 = rings[y]
            cost += ring1[0]
            damage += ring1[1]
            armor += ring1[2]

            for z in range(y + 1, len(rings) + 1):
                if z != len(rings):
                    ring2 = rings[z]
                    cost += ring2[0]
                    damage += ring2[1]
                    armor += ring2[2]
                if not does_player_win_battle(damage, armor):
                    if cost > most_gold:
                        most_gold = cost
                if z != len(rings):
                    ring2 = rings[z]
                    cost -= ring2[0]
                    damage -= ring2[1]
                    armor -= ring2[2]
            cost -= ring1[0]
            damage -= ring1[1]
            armor -= ring1[2]

        if x != len(armors):
            cost -= armors[x][0]
            armor -= armors[x][1]

print(most_gold)