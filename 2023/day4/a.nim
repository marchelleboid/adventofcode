import math
import sequtils
import sets
import strutils

var count = 0
for line in lines("input.txt"):
    let numbers = line.split(": ")[1]
    let winners = numbers.split(" | ")[0]
                    .splitWhitespace
                    .map(proc(x: string): int = parseInt(x))
                    .toHashSet
    let myNumbers = numbers.split(" | ")[1]
                    .splitWhitespace
                    .map(proc(x: string): int = parseInt(x))
    var cardCount = 0
    for m in myNumbers:
        if winners.contains(m):
            cardCount += 1
    
    if cardCount > 0:
        count += (2 ^ (cardCount - 1))

echo count