import sys

with open('input.txt') as f:
    line = f.read()
    instructions = line.split(', ')

x = 0
y = 0
facing = 'N'

for instruction in instructions:
    direction = instruction[0]
    distance = int(instruction[1:])
    if direction == 'R':
        if facing == 'N':
            x += distance
            facing = 'E'
        elif facing == 'S':
            x -= distance
            facing = 'W'
        elif facing == 'E':
            y -= distance
            facing = 'S'
        else:
            y += distance
            facing = 'N'
    else:
        if facing == 'N':
            x -= distance
            facing = 'W'
        elif facing == 'S':
            x += distance
            facing = 'E'
        elif facing == 'E':
            y += distance
            facing = 'N'
        else:
            y -= distance
            facing = 'S'

print(abs(x) + abs(y))
