import algorithm
import deques
import sequtils
import strutils

type
    Source = object
        start: int
        length: int

type
    Mapping = object
        sourceStart: int
        destinationStart: int
        length: int

proc compareMapping(x, y: Mapping): int =
  cmp(x.sourceStart, y.sourceStart)

var seeds: seq[Source]
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
        let splitSeeds = line.split(": ")[1]
            .splitWhitespace
            .map(proc(x: string): int = parseInt(x))
        let pairs = splitSeeds.distribute(int(len(splitSeeds) / 2))
        seeds = pairs.map(proc(x: seq[int]): Source = Source(start: x[0], length: x[1]))
    else:
        let splitLine = line.splitWhitespace.map(proc(x: string): int = parseInt(x))
        mappings[index].add(Mapping(sourceStart: splitLine[1], destinationStart: splitLine[0], length: splitLine[2]))

for i in 0 .. 6:
    var varMapping = mappings[i]
    sort(varMapping, compareMapping)
    mappings[i] = varMapping

var lowest = high(int)
for seed in seeds:
    var stack: Deque[tuple[source: Source, targetMapping: int]]
    stack.addLast((source: seed, targetMapping: 0))
    while len(stack) > 0:
        let current = stack.popFirst
        if current.targetMapping == 7:
            # Reached the end for this one
            lowest = min(lowest, current.source.start)
            continue

        let mapping = mappings[current.targetMapping]
        let currentStart = current.source.start
        let currentLength = current.source.length
        var noMapping = true
        for m in mapping:
            if currentStart >= m.sourceStart and currentStart < m.sourceStart + m.length:
                var nextLength = currentLength
                if currentStart + currentLength > m.sourceStart + m.length:
                    nextLength = m.sourceStart + m.length - currentStart
                    stack.addLast((source: Source(start: currentStart + nextLength, length: currentLength - nextLength), targetMapping: current.targetMapping))
                stack.addLast((source: Source(start: m.destinationStart + (currentStart - m.sourceStart), length: nextLength), targetMapping: current.targetMapping + 1))
                noMapping = false
                break
            elif currentStart < m.sourceStart:
                var nextLength = currentLength
                if m.sourceStart < currentStart + currentLength:
                    nextLength = m.sourceStart - currentStart
                    stack.addLast((source: Source(start: m.sourceStart, length: currentLength - nextLength), targetMapping: current.targetMapping))
                stack.addLast((source: Source(start: currentStart, length: nextLength), targetMapping: current.targetMapping + 1))
                noMapping = false
                break
        if noMapping:
            stack.addLast((source: Source(start: currentStart, length: currentLength), targetMapping: current.targetMapping + 1))

echo lowest