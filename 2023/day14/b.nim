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

proc tiltNorth() =
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

proc tiltWest() =
    for y in 0 ..< height:
        for x in 0 ..< width:
            if grid.contains((x, y)) and grid[(x, y)] == 'O':
                if x > 0:
                    var newX = x
                    for i in countdown(x - 1, 0, 1):
                        if not grid.contains((i, y)):
                            newX = i
                        else:
                            break
                    if newX != x:
                        grid[(newX, y)] = grid[(x, y)]
                        grid.del((x, y))

proc tiltSouth() =
    for x in 0 ..< width:
        for y in countdown(height - 1, 0, 1):
            if grid.contains((x, y)) and grid[(x, y)] == 'O':
                if y < height - 1:
                    var newY = y
                    for i in y + 1 .. height - 1:
                        if not grid.contains((x, i)):
                            newY = i
                        else:
                            break
                    if newY != y:
                        grid[(x, newY)] = grid[(x, y)]
                        grid.del((x, y))

proc tiltEast() =
    for y in 0 ..< height:
        for x in countdown(width - 1, 0, 1):
            if grid.contains((x, y)) and grid[(x, y)] == 'O':
                if x < width - 1:
                    var newX = x
                    for i in x + 1 .. width - 1:
                        if not grid.contains((i, y)):
                            newX = i
                        else:
                            break
                    if newX != x:
                        grid[(newX, y)] = grid[(x, y)]
                        grid.del((x, y))

proc countGrid(g: Table[(int, int), char]): int =
    var count = 0
    for k, v in g:
        if v == 'O':
            count += (height - k[1])
    return count

var results: Table[Table[(int, int), char], int]
results[grid] = 0

var cycleLength = 0
var cycleStart = 0
for i in 1 .. 1000000000:
    tiltNorth()
    tiltWest()
    tiltSouth()
    tiltEast()

    if results.contains(grid):
        cycleStart = results[grid]
        cycleLength = i - cycleStart
        break
    results[grid] = i

var offset = (1000000000 - cycleStart) mod cycleLength

for k, v in results:
    if v == cycleStart + offset:
        echo countGrid(k)
        break