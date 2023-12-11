import sets
import sugar

var grid = collect:
    for line in lines("input.txt"):
        line

var emptyRows = collect:
    for i, row in grid:
        if not row.contains('#'):
            i

var emptyColumns = collect:
    for x in 0 ..< len(grid[0]):
        var empty = true
        for y in 0 ..< len(grid):
            if grid[y][x] == '#':
                empty = false
                break
        if empty:
            x

var points = collect:
    for y in 0 ..< len(grid):
        for x in 0 ..< len(grid[0]):
            if grid[y][x] == '#':
                (x, y)

var seen: HashSet[(int, int)]
var count = 0
for point in points:
    for point2 in points:
        if point == point2:
            continue
        if seen.contains(point2):
            continue
        let emptyRowsBetween = collect:
            for emptyRow in emptyRows:
                if emptyRow > min(point[1], point2[1]) and emptyRow < max(point[1], point2[1]):
                    emptyRow
        let emptyColumnsBetween = collect:
            for emptyColumn in emptyColumns:
                if emptyColumn > min(point[0], point2[0]) and emptyColumn < max(point[0], point2[0]):
                    emptyColumn
        let basicDistance = (abs(point[0] - point2[0]) + abs(point[1] - point2[1]))
        count += (basicDistance + len(emptyRowsBetween) + len(emptyColumnsBetween))
    seen.incl(point)

echo count