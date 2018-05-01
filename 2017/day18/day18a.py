import sys

registers = {}


def get_value(thing):
    try:
        return int(thing)
    except ValueError:
        if thing in registers:
            return registers[thing]
        else:
            return 0


with open('input') as f:
    lines = f.readlines()

last_sound = 0
pointer = 0

while True:
    split_line = lines[pointer].strip().split()
    command = split_line[0]
    arg1 = split_line[1]

    if command == 'snd':
        last_sound = get_value(arg1)
        pointer += 1
    elif command == 'set':
        arg2 = split_line[2]
        registers[arg1] = get_value(arg2)
        pointer += 1
    elif command == 'add':
        arg2 = split_line[2]
        if arg1 in registers:
            value = registers[arg1]
        else:
            value = 0
        registers[arg1] = value + get_value(arg2)
        pointer += 1
    elif command == 'mul':
        arg2 = split_line[2]
        if arg1 in registers:
            value = registers[arg1]
        else:
            value = 0
        registers[arg1] = value * get_value(arg2)
        pointer += 1
    elif command == 'mod':
        arg2 = split_line[2]
        if arg1 in registers:
            value = registers[arg1]
        else:
            value = 0
        registers[arg1] = value % get_value(arg2)
        pointer += 1
    elif command == 'rcv':
        value = get_value(arg1)
        if value != 0:
            print(last_sound)
            sys.exit()
        pointer += 1
    elif command == 'jgz':
        arg2 = split_line[2]
        value1 = get_value(arg1)
        value2 = get_value(arg2)
        if value1 > 0:
            pointer += value2
        else:
            pointer += 1

    if pointer < 0 or pointer >= len(lines):
        break
