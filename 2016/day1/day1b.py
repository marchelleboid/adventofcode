with open('input.txt') as f:
    line = f.read()
    instructions = line.split(', ')

x = 0
y = 0
facing = 'N'

visited = set()

for instruction in instructions:
    direction = instruction[0]
    distance = int(instruction[1:])
    for i in range(1, distance + 1):
        if direction == 'R':
            if facing == 'N':
                x += 1
                new_facing = 'E'
            elif facing == 'S':
                x -= 1
                new_facing = 'W'
            elif facing == 'E':
                y -= 1
                new_facing = 'S'
            else:
                y += 1
                new_facing = 'N'
        else:
            if facing == 'N':
                x -= 1
                new_facing = 'W'
            elif facing == 'S':
                x += 1
                new_facing = 'E'
            elif facing == 'E':
                y += 1
                new_facing = 'N'
            else:
                y -= 1
                new_facing = 'S'
        if (x, y) in visited:
            print(abs(x) + abs(y))
            quit()
        else:
            visited.add((x, y))
    facing = new_facing
