with open('input') as f:
    lines = list(map(lambda x: x[:-1], f.readlines()))

y = 0
x = lines[0].index('|')

direction = 'down'
steps = 0

while True:
    square = lines[y][x]
    if square == '+':
        if direction == 'down' or direction == 'up':
            if lines[y][x - 1] != ' ':
                direction = 'left'
                x -= 1
            else:
                direction = 'right'
                x += 1
        else:
            if lines[y - 1][x] != ' ':
                direction = 'up'
                y -= 1
            else:
                direction = 'down'
                y += 1
    elif square == ' ':
        break
    else:
        if direction == 'down':
            y += 1
        elif direction == 'up':
            y -= 1
        elif direction == 'left':
            x -= 1
        elif direction == 'right':
            x += 1
    steps += 1

print(steps)