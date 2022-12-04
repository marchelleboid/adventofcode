import sequtils
import sets
import strutils

proc doesOverlap(elfALow: int, elfAHigh: int, elfBLow: int, elfBHigh: int): bool =
    var elfASet = toSeq(elfALow .. elfAHigh).toHashSet
    for x in elfBLow .. elfBHigh:
        if elfASet.contains(x):
            return true
    return false

var count = 0
for line in lines("input"):
    let splitLine = line.strip.split(",")
    let firstElf = map(splitLine[0].split("-"), parseInt)
    let secondElf = map(splitLine[1].split("-"), parseInt)
    if doesOverlap(firstElf[0], firstElf[1], secondElf[0], secondElf[1]):
        count += 1

echo count