import copy

screen_width = 50
screen_height = 6

screen = [[False for x in range(screen_width)] for y in range(screen_height)]

with open('input') as f:
    for line in f:
        if 'rect' in line:
            width, height = line.split(' ')[1].split('x')
            width = int(width)
            height = int(height)
            for y in range(0, height):
                for x in range(0, width):
                    screen[y][x] = True
        elif 'rotate row' in line:
            shift = int(line.split(' ')[-1])
            row = int(line.split(' ')[2].split('=')[1])
            row_copy = copy.copy(screen[row])
            for x in range(0, screen_width):
                screen[row][x] = row_copy[x - shift]
        elif 'rotate column' in line:
            shift = int(line.split(' ')[-1])
            column = int(line.split(' ')[2].split('=')[1])
            column_copy = []
            for y in range(0, screen_height):
                column_copy.append(screen[y][column])
            for y in range(0, screen_height):
                screen[y][column] = column_copy[y - shift]

count = 0
for y in range(0, screen_height):
    for x in range(0, screen_width):
        if screen[y][x]:
            count += 1

print(count)