import sequtils
import strutils
import sugar

proc calculatePreviousValue(line: seq[int]): int =
    var firstNumbers = @[line[0]]
    var currentLine = line
    while not all(currentLine, proc (x: int): bool = x == currentLine[0]):
        var newLine: seq[int]
        for i in 0 .. len(currentLine) - 2:
            newLine.add(currentLine[i + 1] - currentLine[i])
        firstNumbers = @[newLine[0]] & firstNumbers
        currentLine = newLine
    return foldl(firstNumbers, b - a)

var count = 0
for line in lines("input.txt"):
    let parsedLine = collect:
        for i in line.splitWhitespace:
            parseInt(i)
    count += calculatePreviousValue(parsedLine)

echo count
