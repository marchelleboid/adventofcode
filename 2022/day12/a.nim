import sets
import strutils

var grid: seq[string]
var startX, startY = 0
for line in lines("input"):
    grid.add(line.strip)
    let startPosition = line.strip.find("S")
    if startPosition >= 0:
        startX = startPosition
        startY = grid.len - 1

proc findShortestPath(): int =
    var nextPositions: seq[(int, int, int)]
    nextPositions.add((startX, startY, 0))
    var visited = initHashSet[(int, int)]()

    while nextPositions.len > 0:
        let (x, y, length) = nextPositions[0]
        nextPositions.delete(0)
        if visited.contains((x, y)):
            continue
        visited.incl((x, y))

        if grid[y][x] == 'E':
            return length

        var currentHeight = grid[y][x]
        if currentHeight == 'S':
            currentHeight = 'a'

        if x < grid[0].len - 1 and not visited.contains((x + 1, y)):
            var newHeight = grid[y][x + 1]
            if newHeight == 'E':
                newHeight = 'z'
            if ord(newHeight) < ord(currentHeight) + 2:
                nextPositions.add((x + 1, y, length + 1))
        if x > 0 and not visited.contains((x - 1, y)):
            var newHeight = grid[y][x - 1]
            if newHeight == 'E':
                newHeight = 'z'
            if ord(newHeight) < ord(currentHeight) + 2:
                nextPositions.add((x - 1, y, length + 1))
        if y < grid.len - 1 and not visited.contains((x, y + 1)):
            var newHeight = grid[y + 1][x]
            if newHeight == 'E':
                newHeight = 'z'
            if ord(newHeight) < ord(currentHeight) + 2:
                nextPositions.add((x, y + 1, length + 1))
        if y > 0 and not visited.contains((x, y - 1)):
            var newHeight = grid[y - 1][x]
            if newHeight == 'E':
                newHeight = 'z'
            if ord(newHeight) < ord(currentHeight) + 2:
                nextPositions.add((x, y - 1, length + 1))

echo findShortestPath()