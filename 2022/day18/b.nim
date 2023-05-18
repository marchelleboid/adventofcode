import sets
import strutils

var grid = initHashSet[(int, int, int)]()
var innerCubes = initHashSet[(int, int, int)]()

proc isInnerCube(x, y, z: int): bool =
    var seen = initHashSet[(int, int, int)]()
    var toCheck = initHashSet[(int, int, int)]()

    toCheck.incl((x, y, z))
    while toCheck.len != 0:
        let (x1, y1, z1) = toCheck.pop()
        if grid.contains((x1, y1, z1)):
            continue
        if innerCubes.contains((x1, y1, z1)):
            return true
        if seen.contains((x1, y1, z1)):
            continue
        if x1 == 0 or x1 == 19 or y1 == 0 or y1 == 19 or z1 == 0 or z1 == 19:
            return false

        toCheck.incl((x1 - 1, y1, z1))
        toCheck.incl((x1 + 1, y1, z1))
        toCheck.incl((x1, y1 - 1, z1))
        toCheck.incl((x1, y1 + 1, z1))
        toCheck.incl((x1, y1, z1 - 1))
        toCheck.incl((x1, y1, z1 + 1))

        seen.incl((x1, y1, z1))

    return true

for line in lines("input"):
    var splitLine = line.split(",")
    grid.incl((parseInt(splitLine[0]), parseInt(splitLine[1]), parseInt((splitLine[2]))))

for x in 0 .. 19:
    for y in 0 .. 19:
        for z in 0 .. 19:
            if isInnerCube(x, y, z):
                innerCubes.incl((x, y, z))

var count = 0
for g in grid:
    var openSides = 6
    if grid.contains((g[0] - 1, g[1], g[2])) or innerCubes.contains((g[0] - 1, g[1], g[2])):
        openSides -= 1
    if grid.contains((g[0] + 1, g[1], g[2])) or innerCubes.contains((g[0] + 1, g[1], g[2])):
        openSides -= 1
    if grid.contains((g[0], g[1] - 1, g[2])) or innerCubes.contains((g[0], g[1] - 1, g[2])):
        openSides -= 1
    if grid.contains((g[0], g[1] + 1, g[2])) or innerCubes.contains((g[0], g[1] + 1, g[2])):
        openSides -= 1
    if grid.contains((g[0], g[1], g[2] - 1)) or innerCubes.contains((g[0], g[1], g[2] - 1)):
        openSides -= 1
    if grid.contains((g[0], g[1], g[2] + 1)) or innerCubes.contains((g[0], g[1], g[2] + 1)):
        openSides -= 1
    count += openSides

echo count