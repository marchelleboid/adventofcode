RACE_TIME = 2503

farthest = 0

with open('input') as f:
    for line in f:
        split_line = line.split(" ")
        speed = int(split_line[3])
        flight_time = int(split_line[6])
        rest_time = int(split_line[-2])

        cycle_time = flight_time + rest_time
        complete_cycles = int(RACE_TIME/cycle_time)

        distance = complete_cycles*flight_time*speed

        last_cycle = RACE_TIME%cycle_time
        if last_cycle < flight_time:
            distance += last_cycle*speed
        else:
            distance += flight_time*speed

        if distance > farthest:
            farthest = distance

print(farthest)
