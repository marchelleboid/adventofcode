import tables
import strformat
import strutils

proc getPointsSet(line: seq[string]): Table[(int, int), int] =
    var points = initTable[(int, int), int]()
    var x, y, steps = 0
    for move in line:
        let value = parseInt(move[1 .. ^1])
        case move[0]:
            of 'U':
                for _ in 0 ..< value:
                    y += 1
                    steps += 1
                    discard points.hasKeyOrPut((x,y), steps)
            of 'R':
                for _ in 0 ..< value:
                    x += 1
                    steps += 1
                    discard points.hasKeyOrPut((x,y), steps)
            of 'D':
                for _ in 0 ..< value:
                    y -= 1
                    steps += 1
                    discard points.hasKeyOrPut((x,y), steps)
            of 'L':
                for _ in 0 ..< value:
                    x -= 1
                    steps += 1
                    discard points.hasKeyOrPut((x,y), steps)
            else:
                raise newException(ValueError, fmt"Unknown thing {move[0]}")
    return points

let lines = readFile("input").strip().split("\n")

var points1 = getPointsSet(lines[0].split(","))
var points2 = getPointsSet(lines[1].split(","))

var smallestDistance = 9999999
for k in points1.keys:
    if points2.hasKey(k):
        let distance = points1[k] + points2[k]
        smallestDistance = min(distance, smallestDistance)

echo smallestDistance
