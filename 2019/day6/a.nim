import strutils
import tables

proc countOrbits(orbits: Table[string, seq[string]], obj: string, depth: int): int =
    var count = depth
    for child in orbits.getOrDefault(obj, newSeq[string](0)):
        count += countOrbits(orbits, child, depth + 1)
    return count

var orbits = initTable[string, seq[string]]()
for line in lines("input"):
    let splitLine = line.strip.split(")")
    let parent = splitLine[0]
    let child = splitLine[1]

    if orbits.hasKeyOrPut(parent, @[child]):
        orbits[parent].add(child)

echo countOrbits(orbits, "COM", 0)