registers = {'a': 0, 'b': 0, 'c': 0, 'd': 0, 'e': 0, 'f': 0, 'g': 0, 'h': 0}


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

pointer = 0
mul_count = 0

while True:
    split_line = lines[pointer].strip().split()
    command = split_line[0]
    arg1 = split_line[1]

    if command == 'set':
        arg2 = split_line[2]
        registers[arg1] = get_value(arg2)
        pointer += 1
    elif command == 'sub':
        arg2 = split_line[2]
        value = registers[arg1]
        registers[arg1] = value - get_value(arg2)
        pointer += 1
    elif command == 'mul':
        mul_count += 1
        arg2 = split_line[2]
        value = registers[arg1]
        registers[arg1] = value * get_value(arg2)
        pointer += 1
    elif command == 'jnz':
        arg2 = split_line[2]
        value1 = get_value(arg1)
        value2 = get_value(arg2)
        if value1 != 0:
            pointer += value2
        else:
            pointer += 1

    if pointer < 0 or pointer >= len(lines):
        break

print(mul_count)