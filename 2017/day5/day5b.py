with open('input') as f:
    instructions = list(map(lambda x: int(x.strip()), f.readlines()))
    position = 0
    steps = 0
    while 0 <= position < len(instructions):
        new_position = position + instructions[position]
        if instructions[position] >= 3:
            instructions[position] = instructions[position] - 1
        else:
            instructions[position] = instructions[position] + 1
        position = new_position
        steps += 1
    print(steps)