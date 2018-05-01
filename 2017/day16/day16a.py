from collections import deque

programs = deque('abcdefghijklmnop')

with open('input') as f:
    moves = f.readline().strip().split(',')

for move in moves:
    if move[0] == 's':
        programs.rotate(int(move[1:]))
    elif move[0] == 'x':
        position1 = int(move[1:].split('/')[0])
        position2 = int(move[1:].split('/')[1])
        tmp = programs[position1]
        programs[position1] = programs[position2]
        programs[position2] = tmp
    elif move[0] == 'p':
        partner1 = move[1]
        partner2 = move[3]
        index1 = programs.index(partner1)
        index2 = programs.index(partner2)
        programs[index1] = partner2
        programs[index2] = partner1

print(''.join(programs))
