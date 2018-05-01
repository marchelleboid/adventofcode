grid = []

for i in range(10001):
    row = []
    for j in range(10001):
        row.append('.')
    grid.append(row)

with open('input') as f:
    line_pointer = 488
    for line in f:
        column_pointer = 488
        for c in line.strip():
            grid[line_pointer][column_pointer] = c
            column_pointer += 1
        line_pointer += 1

x = 500
y = 500
direction = 'up'

new_infections = 0

for z in range(10000):
    current_node = grid[y][x]
    if current_node == '.':
        new_infections += 1
        grid[y][x] = '#'
        if direction == 'up':
            direction = 'left'
        elif direction == 'down':
            direction = 'right'
        elif direction == 'left':
            direction = 'down'
        else:
            direction = 'up'
    else:
        grid[y][x] = '.'
        if direction == 'up':
            direction = 'right'
        elif direction == 'down':
            direction = 'left'
        elif direction == 'left':
            direction = 'up'
        else:
            direction = 'down'

    if direction == 'up':
        y -= 1
    elif direction == 'down':
        y += 1
    elif direction == 'left':
        x -= 1
    else:
        x += 1

print(new_infections)
