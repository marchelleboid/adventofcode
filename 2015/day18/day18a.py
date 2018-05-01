import sys
from copy import deepcopy

SIZE = 100
STEPS = 100

state1 = [[False for x in range(0, SIZE)] for x in range(0, SIZE)]
state2 = deepcopy(state1)

row = 0
with open('input') as f:
    for line in f:
        line = line.strip()
        col = 0
        for c in line:
            state1[row][col] = True if c == "#" else False
            col += 1
        row += 1

def is_light_on(x, y):
    if x < 0 or y < 0 or x >= SIZE or y >= SIZE:
        return False
    else:
        return state1[x][y]

for r in range(0, STEPS):
    for x in range(0, SIZE):
        for y in range(0, SIZE):
            sum_of_neighbors = is_light_on(x - 1, y - 1) + \
                               is_light_on(x - 1, y) + \
                               is_light_on(x - 1, y + 1) + \
                               is_light_on(x, y - 1) + \
                               is_light_on(x, y + 1) + \
                               is_light_on(x + 1, y - 1) + \
                               is_light_on(x + 1, y) + \
                               is_light_on(x + 1, y + 1)
            if is_light_on(x, y):
                state2[x][y] = sum_of_neighbors == 2 or sum_of_neighbors == 3
            else:
                state2[x][y] = sum_of_neighbors == 3

    state1 = deepcopy(state2)

print(sum(sum(x) for x in state1))
