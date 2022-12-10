import strutils
import tables

proc countOrbits(orbits: Table[string, seq[string]], current: string, depth: int): int =
    var count = depth
    for child in orbits.getOrDefault(current, newSeq[string](0)):
        count += countOrbits(orbits, child, depth + 1)
    return count

proc findPath(orbits: Table[string, seq[string]], current: string, target: string, path: var seq[string]): bool =
    path.add(current)
    if current == target:
        return true

    for child in orbits.getOrDefault(current, newSeq[string](0)):
        if findPath(orbits, child, target, path):
            return true

    path.delete(path.len - 1)
    return false

var orbits = initTable[string, seq[string]]()
for line in lines("input"):
    let splitLine = line.strip.split(")")
    let parent = splitLine[0]
    let child = splitLine[1]

    if orbits.hasKeyOrPut(parent, @[child]):
        orbits[parent].add(child)

var pathYou = newSeq[string](0)
var pathSan = newSeq[string](0)
discard findPath(orbits, "COM", "YOU", pathYou)
discard findPath(orbits, "COM", "SAN", pathSan)

var commonAncestorIndex = 0
for i in 0 .. min(pathYou.len, pathSan.len):
    if pathYou[i] != pathSan[i]:
        break
    commonAncestorIndex = i

echo (pathYou.len - commonAncestorIndex - 2) + (pathSan.len - commonAncestorIndex - 2)