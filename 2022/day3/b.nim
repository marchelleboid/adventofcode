import sets
import strutils

var count = 0
var groupCount = 0
var firstSet: HashSet[char]
var secondSet: HashSet[char]
for line in lines("input"):
    let lineSet = toHashSet(line.strip)
    if groupCount == 0:
        firstSet = lineSet
        groupCount = 1
    elif groupCount == 1:
        secondSet = lineSet
        groupCount = 2
    else:
        var intersectionSet = firstSet * secondSet * lineSet
        let commonValue = intersectionSet.pop
        if ord(commonValue) >= 65 and ord(commonValue) <= 90:
            count += ord(commonValue) - 38
        else:
            count += ord(commonValue) - 96
        groupCount = 0

echo count