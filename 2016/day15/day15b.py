class Disc:
    def __init__(self, positions, position):
        self.positions = positions
        self.position = position

    def position_at_time(self, time):
        return (self.position + time) % self.positions


discs = {1: Disc(17, 1), 2: Disc(7, 0), 3: Disc(19, 2), 4: Disc(5, 0), 5: Disc(3, 0), 6: Disc(13, 5), 7: Disc(11, 0)}

delay = 0

while True:
    will_work = True
    for key, value in discs.items():
        if value.position_at_time(delay + key) != 0:
            will_work = False
            break
    if will_work:
        break
    delay += 1

print(delay)