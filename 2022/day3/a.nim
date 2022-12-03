import sets
import strutils

var count = 0
for line in lines("input"):
    let strippedLine = line.strip
    let firstHalf = strippedLine[0 .. int(strippedLine.len / 2) - 1]
    let secondHalf = strippedLine[int(strippedLine.len / 2) .. ^1]
    let firstHalfSet = toHashSet(firstHalf)
    let secondHalfSet = toHashSet(secondHalf)
    var intersectionSet = firstHalfSet * secondHalfSet
    let commonValue = intersectionSet.pop
    if ord(commonValue) >= 65 and ord(commonValue) <= 90:
        count += ord(commonValue) - 38
    else:
        count += ord(commonValue) - 96

echo count