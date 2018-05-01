registers = {'a': 0, 'b': 0, 'c': 1, 'd': 0}

with open('input') as f:
    instructions = f.readlines()

pointer = 0
while True:
    instruction = instructions[pointer]
    split_line = instruction.strip().split(' ')
    command = split_line[0]
    if command == 'cpy':
        value = split_line[1]
        register = split_line[2]
        if value in 'abcd':
            registers[register] = registers[value]
        else:
            registers[register] = int(value)
        pointer += 1
    elif command == 'inc':
        register = split_line[1]
        registers[register] = registers[register] + 1
        pointer += 1
    elif command == 'dec':
        register = split_line[1]
        registers[register] = registers[register] - 1
        pointer += 1
    elif command == 'jnz':
        value = split_line[1]
        if value in 'abcd':
            value = registers[value]
        if value != 0:
            pointer += int(split_line[2])
        else:
            pointer += 1
    if pointer >= len(instructions):
        break

print(registers['a'])