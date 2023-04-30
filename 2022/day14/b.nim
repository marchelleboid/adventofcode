import sequtils
import sets
import strutils

proc toCoordinate(s: string): (int, int) =
    let split = s.split(",")
    return (parseInt(split[0]), parseInt(split[1]))

var grid = initHashSet[(int, int)]()
var maxY = 0
for line in lines("input"):
    let endpoints = map(line.strip.split(" -> "), toCoordinate)
    var previousEndpoint = endpoints[0]
    for endpoint in endpoints[1..^1]:
        if previousEndpoint[0] == endpoint[0]:
            for i in min(previousEndpoint[1], endpoint[1]) .. max(previousEndpoint[1], endpoint[1]):
                grid.incl((endpoint[0], i))
                maxY = max(i, maxY)
        else:
            for i in min(previousEndpoint[0], endpoint[0]) .. max(previousEndpoint[0], endpoint[0]):
                grid.incl((i, endpoint[1]))
                maxY = max(endpoint[1], maxY)
        previousEndpoint = endpoint

let floorY = maxY + 2

var count = 0
while true:
    var sandX = 500
    var sandY = 0
    var endIt = false
    while not endIt:
        if sandY + 1 == floorY:
            grid.incl((sandX, sandY))
            count += 1
            break
        elif not grid.contains((sandX, sandY + 1)):
            sandY += 1
        elif not grid.contains((sandX - 1, sandY + 1)):
            sandX -= 1
            sandY += 1
        elif not grid.contains((sandX + 1, sandY + 1)):
            sandX += 1
            sandY += 1
        else:
            grid.incl((sandX, sandY))
            count += 1
            if sandX == 500 and sandY == 0:
                endIt = true
            break
    if endIt:
        break

echo count