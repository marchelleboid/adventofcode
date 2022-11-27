import std/strutils

var weight = 0
for line in lines("input"):
    var moduleWeight = line.strip.parseInt
    weight += (int(moduleWeight / 3) - 2)

echo weight