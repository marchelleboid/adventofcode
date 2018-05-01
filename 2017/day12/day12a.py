programs = {}

connected_to_zero = {0}

with open('input') as f:
    for line in f:
        split_line = line.strip().split(' <-> ')
        program = int(split_line[0])
        connected_programs = split_line[1].split(', ')
        programs[program] = set(map(int, connected_programs))

last_size = len(connected_to_zero)

while True:
    for key, value in programs.items():
        if key not in connected_to_zero:
            if len(connected_to_zero.intersection(value)) != 0:
                connected_to_zero.update(value)
                connected_to_zero.add(key)

    if last_size == len(connected_to_zero):
        break
    last_size = len(connected_to_zero)

print(len(connected_to_zero))