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

func isHorizontalReflection(grid: seq[string], start: int): bool =
    var x = 1
    while true:
        if start - x == -1 or start + 1 + x == len(grid):
            return true
        elif grid[start - x] != grid[start + 1 + x]:
            return false
        x += 1

func columnToString(grid: seq[string], index: int): string =
    var column = ""
    for row in grid:
        column = column & row[index]
    return column

func isVerticalReflection(grid: seq[string], start: int): bool =
    var x = 1
    while true:
        if start - x == -1 or start + 1 + x == len(grid[0]):
            return true
        elif columnToString(grid, start - x) != columnToString(grid, start + 1 + x):
            return false
        x += 1

var count = 0
for grid in grids:
    for y in 0 ..< len(grid) - 1:
        if grid[y] == grid[y + 1]:
            if isHorizontalReflection(grid, y):
                count += (y + 1)*100

    for x in 0 ..< len(grid[0]) - 1:
        if columnToString(grid, x) == columnToString(grid, x + 1):
            if isVerticalReflection(grid, x):
                count += (x + 1)

echo count