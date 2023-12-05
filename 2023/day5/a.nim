import sequtils
import strutils

type
    Mapping = object
        sourceStart: int
        destinationStart: int
        length: int

var seeds: seq[int]
var mappings: array[0 .. 6, seq[Mapping]]
for i in 0 .. 6:
    mappings[i] = @[]

var index = -1
for line in lines("input.txt"):
    if line.isEmptyOrWhitespace:
        index += 1
    elif line.contains("map"):
        continue
    elif index == -1:
        seeds = line.split(": ")[1]
            .splitWhitespace
            .map(proc(x: string): int = parseInt(x))
    else:
        let splitLine = line.splitWhitespace.map(proc(x: string): int = parseInt(x))
        mappings[index].add(Mapping(sourceStart: splitLine[1], destinationStart: splitLine[0], length: splitLine[2]))

var lowest = high(int)
for seed in seeds:
    var nextSource = seed
    for mapping in mappings:
        for r in mapping:
            if nextSource >= r.sourceStart and nextSource < r.sourceStart + r.length:
                nextSource = r.destinationStart + (nextSource - r.sourceStart)
                break

    lowest = min(lowest, nextSource)

echo lowest