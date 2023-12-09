import sequtils
import strutils
import sugar

proc calculateNextValue(line: seq[int]): int =
    var lastNumbers = @[line[^1]]
    var currentLine = line
    while not all(currentLine, proc (x: int): bool = x == currentLine[0]):
        var newLine: seq[int]
        for i in 0 .. len(currentLine) - 2:
            newLine.add(currentLine[i + 1] - currentLine[i])
        lastNumbers.add(newLine[^1])
        currentLine = newLine
    return foldl(lastNumbers, a + b)

var count = 0
for line in lines("input.txt"):
    let parsedLine = collect:
        for i in line.splitWhitespace:
            parseInt(i)
    count += calculateNextValue(parsedLine)

echo count
