import std/editdistance
import strutils

var grids: seq[seq[string]]
var currentGrid: seq[string]
for line in lines("input.txt"):
    if line.isEmptyOrWhitespace:
        grids.add(currentGrid)
        currentGrid = @[]
    else:
        currentGrid.add(line)
grids.add(currentGrid)

func isHorizontalReflection(grid: seq[string], y1, y2: int): bool =
    let midpoint = int((y1 + y2)/2)
    var i = 0
    while true:
        if midpoint - i == -1 or midpoint + 1 + i == len(grid):
            return true
        elif midpoint - i == y1 or midpoint + 1 + i == y2:
            # Ignore the smudge
            i += 1
            continue
        elif grid[midpoint - i] != grid[midpoint + 1 + i]:
            return false
        i += 1
    return false

func columnToString(grid: seq[string], index: int): string =
    var column = ""
    for row in grid:
        column = column & row[index]
    return column

func isVerticalReflection(grid: seq[string], x1, x2: int): bool =
    let midpoint = int((x1 + x2)/2)
    var x = 0
    while true:
        if midpoint - x == -1 or midpoint + 1 + x == len(grid[0]):
            return true
        elif midpoint - x == x1 or midpoint + 1 + x == x2:
            # Ignore the smudge
            x += 1
            continue
        elif columnToString(grid, midpoint - x) != columnToString(grid, midpoint + 1 + x):
            return false
        x += 1
    return false

func findNewHorizontalReflection(grid: seq[string]): int =
    for y in 0 ..< len(grid) - 1:
        for y2 in countup(y + 1, len(grid) - 1, 2):
            if editDistance(grid[y], grid[y2]) == 1:
                if isHorizontalReflection(grid, y, y2):
                    return int((y + y2)/2)
    return -1

func findNewVerticalReflection(grid: seq[string]): int =
    for x in 0 ..< len(grid[0]) - 1:
        for x2 in countup(x + 1, len(grid[0]) - 1, 2):
            if editDistance(columnToString(grid, x), columnToString(grid, x2)) == 1:
                if isVerticalReflection(grid, x, x2):
                    return int((x + x2)/2)
    return -1

var count = 0
for i, grid in grids:
    var y = findNewHorizontalReflection(grid)
    if y != -1:
        count += (y + 1)*100

    var x = findNewVerticalReflection(grid)
    if x != -1:
        count += (x + 1)

echo count