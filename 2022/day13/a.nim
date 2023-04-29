import strutils
import std/json

type
  InOrder = enum
    yes, no, maybe

proc isIntInOrder(left, right: int): InOrder =
    if left < right:
        return yes
    if left > right:
        return no
    else:
        return maybe

proc isListInOrder(left, right: seq[JsonNode]): InOrder =
    if len(left) == 0 and len(right) != 0:
        return yes
    elif len(left) != 0 and len(right) == 0:
        return no
    elif len(left) == 0 and len(right) == 0:
        return maybe

    let leftElement = left[0]
    let rightElement = right[0]

    var comparison = maybe
    if leftElement.kind == JInt and rightElement.kind == JInt:
        comparison = isIntInOrder(leftElement.getInt(), rightElement.getInt())
    elif leftElement.kind == JArray and rightElement.kind == JArray:
        comparison = isListInOrder(leftElement.getElems(), rightElement.getElems())
    elif leftElement.kind == JInt and rightElement.kind == JArray:
        comparison = isListInOrder(@[leftElement], rightElement.getElems())
    elif leftElement.kind == JArray and rightElement.kind == JInt:
        comparison = isListInOrder(leftElement.getElems(), @[rightElement])

    if comparison == maybe:
        return isListInOrder(left[1..^1], right[1..^1])
    else:
        return comparison

var currentPair = 1
var count = 0
var leftPacket = ""
for line in lines("input"):
    let strippedLine = line.strip
    if leftPacket.isEmptyOrWhitespace:
        leftPacket = strippedLine
    elif not strippedLine.isEmptyOrWhitespace:
        if isListInOrder(parseJson(leftPacket).getElems(), parseJson(strippedLine).getElems()) == yes:
            count += currentPair
    else:
        leftPacket = ""
        currentPair += 1

echo count