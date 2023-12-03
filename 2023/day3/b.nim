import hashes
import sets
import strutils
import tables

type
    Part = object
        start: int
        last: int
        id: int

proc hash(x: Part): Hash =
  return x.id

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

var parts: Table[int, seq[Part]]

var lineNumber = 0
for line in grid:
    var partStart = -1
    for i, c in line:
        if c.isDigit and partStart == -1:
            partStart = i
        elif not c.isDigit and partStart != -1:
            let partId = parseInt(line[partStart .. i - 1])
            if isAdjacentToSymbol(grid, partStart, i - 1, lineNumber):
                let part = Part(start: partStart, last: i - 1, id: partId)
                if parts.contains(lineNumber):
                    parts[lineNumber].add(part)
                else:
                    parts[lineNumber] = @[part]
            partStart = -1
        elif i == len(line) - 1 and partStart != -1:
            # End of line numbers
            let partId = parseInt(line[partStart .. i])
            if isAdjacentToSymbol(grid, partStart, i - 1, lineNumber):
                let part = Part(start: partStart, last: i - 1, id: partId)
                if parts.contains(lineNumber):
                    parts[lineNumber].add(part)
                else:
                    parts[lineNumber] = @[part]
    lineNumber += 1

func getAdjacentsParts(lineNumber, i: int, parts: Table[int, seq[Part]]): HashSet[Part] =
    var adjacentParts: seq[Part]
    if parts.hasKey(lineNumber - 1):
        for part in parts[lineNumber - 1]:
            if i >= part.start - 1 and i <= part.last + 1:
                adjacentParts.add(part)
    if parts.hasKey(lineNumber + 1):
        for part in parts[lineNumber + 1]:
            if i >= part.start - 1 and i <= part.last + 1:
                adjacentParts.add(part)
    for part in parts[lineNumber]:
            if i == part.last + 1 or i == part.start - 1:
                adjacentParts.add(part)
    return adjacentParts.toHashSet

var count = 0
lineNumber = 0
for line in grid:
    for i, c in line:
        if c != '*':
            continue
        var adjacentParts = getAdjacentsParts(lineNumber, i, parts)
        if len(adjacentParts) == 2:
            count += (adjacentParts.pop.id * adjacentParts.pop.id)
    lineNumber += 1

echo count