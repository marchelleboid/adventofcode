import sequtils
import sets
import strutils

var cardCounts: array[0 .. 204, int]
for i in 0 .. 204:
    cardCounts[i] = 1

var index = 0
for line in lines("input.txt"):
    let numbers = line.split(": ")[1]
    let winners = numbers.split(" | ")[0]
                    .splitWhitespace
                    .map(proc(x: string): int = parseInt(x))
                    .toHashSet
    let myNumbers = numbers.split(" | ")[1]
                    .splitWhitespace
                    .map(proc(x: string): int = parseInt(x))
    var matchCount = 0
    for m in myNumbers:
        if winners.contains(m):
            matchCount += 1

    if matchCount > 0:
        for i in index + 1 .. index + matchCount:
            cardCounts[i] += cardCounts[index]
    
    index += 1

echo cardCounts.foldl(a + b)
