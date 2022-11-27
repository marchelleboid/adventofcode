import sets
import strformat
import strutils

proc getPointsSet(line: seq[string]): HashSet[(int, int)] =
    var points = initHashSet[(int, int)]()
    var x, y = 0
    for move in line:
        let value = parseInt(move[1 .. ^1])
        case move[0]:
            of 'U':
                for _ in 0 ..< value:
                    y += 1
                    points.incl((x, y))
            of 'R':
                for _ in 0 ..< value:
                    x += 1
                    points.incl((x, y))
            of 'D':
                for _ in 0 ..< value:
                    y -= 1
                    points.incl((x, y))
            of 'L':
                for _ in 0 ..< value:
                    x -= 1
                    points.incl((x, y))
            else:
                raise newException(ValueError, fmt"Unknown thing {move[0]}")
    return points

let lines = readFile("input").strip().split("\n")

var points1 = getPointsSet(lines[0].split(","))
var points2 = getPointsSet(lines[1].split(","))

var interPoints = points1 * points2

var smallestDistance = 9999999
for i in interPoints:
    let distance = abs(i[0]) + abs(i[1])
    smallestDistance = min(distance, smallestDistance)

echo smallestDistance
