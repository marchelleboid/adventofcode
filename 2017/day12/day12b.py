programs = {}

with open('input') as f:
    for line in f:
        split_line = line.strip().split(' <-> ')
        program = int(split_line[0])
        connected_programs = split_line[1].split(', ')
        programs[program] = set(map(int, connected_programs))

groups = []

for key in programs.keys():
    in_group = False
    for group in groups:
        if key in group:
            in_group = True
            break

    if in_group:
        continue

    connected = {key}
    last_size = len(connected)

    while True:
        for key2, value in programs.items():
            if key2 not in connected:
                if len(connected.intersection(value)) != 0:
                    connected.update(value)
                    connected.add(key2)

        if last_size == len(connected):
            break
        last_size = len(connected)

    groups.append(sorted(connected))

print(len(groups))