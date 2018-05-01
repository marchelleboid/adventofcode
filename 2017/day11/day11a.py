with open('input') as f:
    line = f.readline().strip()

moves = line.split(',')

x = 0
y = 0
z = 0

for move in moves:
    if move == 'nw':
        x -= 1
        y += 1
    elif move == 'n':
        y += 1
        z -= 1
    elif move == 'ne':
        x += 1
        z -= 1
    elif move == 'se':
        x += 1
        y -= 1
    elif move == 's':
        y -= 1
        z += 1
    elif move == 'sw':
        x -= 1
        z += 1

print(max(abs(x), abs(y), abs(z)))
