with open('input') as f:
    line = f.readline().strip()

moves = line.split(',')

x = 0
y = 0
z = 0

max_distance = 0

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
    now = max(abs(x), abs(y), abs(z))
    if now > max_distance:
        max_distance = now

print(max_distance)
