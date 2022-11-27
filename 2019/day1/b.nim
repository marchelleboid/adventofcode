import std/strutils

proc countFuelRecursive(fuel: int): int =
    if fuel <= 0:
        return 0
    else:
        fuel + countFuelRecursive(int(fuel / 3) - 2)

var weight = 0
for line in lines("input"):
    var moduleWeight = line.strip.parseInt
    weight += countFuelRecursive(int(moduleWeight / 3) - 2)

echo weight