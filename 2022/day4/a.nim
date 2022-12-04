import sequtils
import strutils

proc isAInsideB(elfALow: int, elfAHigh: int, elfBLow: int, elfBHigh: int): bool =
    return elfALow >= elfBLow and elfAHigh <= elfBHigh

var count = 0
for line in lines("input"):
    let splitLine = line.strip.split(",")
    let firstElf = map(splitLine[0].split("-"), parseInt)
    let secondElf = map(splitLine[1].split("-"), parseInt)
    if isAInsideB(firstElf[0], firstElf[1], secondElf[0], secondElf[1]) or
        isAInsideB(secondElf[0], secondElf[1], firstElf[0], firstElf[1]):
        count += 1

echo count