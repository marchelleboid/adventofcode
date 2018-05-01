class Reindeer:
    def __init__(self, speed, flight_time, rest_time):
        self.speed = speed
        self.flight_time = flight_time
        self.rest_time = rest_time
        self.distance = 0
        self.points = 0
        self.flying = True
        self.time_in_current_state = 0

    def next_second(self):
        self.time_in_current_state += 1
        if self.flying:
            if self.time_in_current_state > self.flight_time:
                self.flying = False
                self.time_in_current_state = 1
            else:
                self.distance += self.speed
        else:
            if self.time_in_current_state > self.rest_time:
                self.flying = True
                self.time_in_current_state = 1
                self.distance += self.speed

reindeers = []

with open('input') as f:
    for line in f:
        split_line = line.split(" ")
        speed = int(split_line[3])
        flight_time = int(split_line[6])
        rest_time = int(split_line[-2])

        reindeers.append(Reindeer(speed, flight_time, rest_time))


for x in range(0, 2503):
    for reindeer in reindeers:
        reindeer.next_second()

    lead_distance = 0
    for reindeer in reindeers:
        if reindeer.distance > lead_distance:
            lead_distance = reindeer.distance

    for reindeer in reindeers:
        if reindeer.distance == lead_distance:
            reindeer.points += 1

max_points = 0
for reindeer in reindeers:
    if reindeer.points > max_points:
            max_points = reindeer.points

print(max_points)