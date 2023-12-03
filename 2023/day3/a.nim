import strutils

var grid: seq[string]
for line in lines("input.txt"):
    grid.add(line)

func isAdjacentToSymbol(grid: seq[string], start, last, lineNumber: int): bool =
    if lineNumber != 0:
        let leftEnd = if start == 0: 0 else: start - 1
        let rightEnd = if last == len(grid[0]) - 1: last else: last + 1
        for i in leftEnd .. rightEnd:
            let c = grid[lineNumber - 1][i]
            if not c.isDigit and c != '.':
                return true
    if lineNumber != len(grid) - 1:
        let leftEnd = if start == 0: 0 else: start - 1
        let rightEnd = if last == len(grid[0]) - 1: last else: last + 1
        for i in leftEnd .. rightEnd:
            let c = grid[lineNumber + 1][i]
            if not c.isDigit and c != '.':
                return true
    if start != 0:
        let c = grid[lineNumber][start - 1]
        if not c.isDigit and c != '.':
                return true
    if last != len(grid[0]) - 1:
        let c = grid[lineNumber][last + 1]
        if not c.isDigit and c != '.':
                return true
    return false

var count = 0
var lineNumber = 0
for line in grid:
    var partStart = -1
    for i, c in line:
        if c.isDigit and partStart == -1:
            partStart = i
        elif not c.isDigit and partStart != -1:
            let partId = parseInt(line[partStart .. i - 1])
            if isAdjacentToSymbol(grid, partStart, i - 1, lineNumber):
                count += partId
            partStart = -1
        elif i == len(line) - 1 and partStart != -1:
            # End of line
            let partId = parseInt(line[partStart .. i])
            if isAdjacentToSymbol(grid, partStart, i - 1, lineNumber):
                count += partId
    lineNumber += 1

echo count