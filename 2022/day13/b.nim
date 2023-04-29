import strutils
import std/algorithm
import std/json

proc isIntInOrder(left, right: int): int =
    if left < right:
        return -1
    if left > right:
        return 1
    else:
        return 0

proc isListInOrder(left, right: seq[JsonNode]): int =
    if len(left) == 0 and len(right) != 0:
        return -1
    elif len(left) != 0 and len(right) == 0:
        return 1
    elif len(left) == 0 and len(right) == 0:
        return 0

    let leftElement = left[0]
    let rightElement = right[0]

    var comparison = 0
    if leftElement.kind == JInt and rightElement.kind == JInt:
        comparison = isIntInOrder(leftElement.getInt(), rightElement.getInt())
    elif leftElement.kind == JArray and rightElement.kind == JArray:
        comparison = isListInOrder(leftElement.getElems(), rightElement.getElems())
    elif leftElement.kind == JInt and rightElement.kind == JArray:
        comparison = isListInOrder(@[leftElement], rightElement.getElems())
    elif leftElement.kind == JArray and rightElement.kind == JInt:
        comparison = isListInOrder(leftElement.getElems(), @[rightElement])

    if comparison == 0:
        return isListInOrder(left[1..^1], right[1..^1])
    else:
        return comparison

var packets = newSeq[JsonNode]()
for line in lines("input"):
    let strippedLine = line.strip
    if not strippedLine.isEmptyOrWhitespace:
        packets.add(parseJson(strippedLine))
    
packets.add(parseJson("[[2]]"))
packets.add(parseJson("[[6]]"))

packets.sort do (x, y: JsonNode) -> int:
  isListInOrder(x.getElems(), y.getElems())

var temp = 0
for i, packet in packets:
    if packet == parseJson("[[2]]"):
        temp = i + 1
    elif packet == parseJson("[[6]]"):
        echo temp * (i + 1)
        break
