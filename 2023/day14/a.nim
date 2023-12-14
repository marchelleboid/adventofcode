import tables

var grid: Table[(int, int), char]
var height = 0
var width = 0
for line in lines("input.txt"):
    width = len(line)
    for x, c in line:
        if c == '#' or c == 'O':
            grid[(x, height)] = c
    height += 1

for x in 0 ..< width:
    for y in 0 ..< height:
        if grid.contains((x, y)) and grid[(x, y)] == 'O':
            if y > 0:
                var newY = y
                for i in countdown(y - 1, 0, 1):
                    if not grid.contains((x, i)):
                        newY = i
                    else:
                        break
                if newY != y:
                    grid[(x, newY)] = grid[(x, y)]
                    grid.del((x, y))

var count = 0
for k, v in grid:
    if v == 'O':
        count += (height - k[1])

echo count