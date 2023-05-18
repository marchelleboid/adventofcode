import sets
import strutils

var grid = initHashSet[(int, int, int)]()

for line in lines("input"):
    var splitLine = line.split(",")
    grid.incl((parseInt(splitLine[0]), parseInt(splitLine[1]), parseInt((splitLine[2]))))

var count = 0
for g in grid:
    var openSides = 6
    if grid.contains((g[0] - 1, g[1], g[2])):
        openSides -= 1
    if grid.contains((g[0] + 1, g[1], g[2])):
        openSides -= 1
    if grid.contains((g[0], g[1] - 1, g[2])):
        openSides -= 1
    if grid.contains((g[0], g[1] + 1, g[2])):
        openSides -= 1
    if grid.contains((g[0], g[1], g[2] - 1)):
        openSides -= 1
    if grid.contains((g[0], g[1], g[2] + 1)):
        openSides -= 1
    count += openSides

echo count