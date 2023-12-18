import strutils

var x, y, exteriorPoints = 0
var vertices: seq[(int, int)]
vertices.add((0, 0))
for line in lines("input.txt"):
    let instruction = line.split(" ")[2][2 .. ^2]
    let direction = instruction[^1 .. ^1]
    let metersHex = instruction[0 .. ^2]
    let meters = fromHex[int](metersHex)

    if direction == "0":
        x += meters
    elif direction == "2":
        x -= meters
    elif direction == "3":
        y -= meters
    else:
        y += meters
    exteriorPoints += meters
    
    vertices.add((x, y))

# Ignore final (0, 0)
var doubleArea = 0
for i in 0 ..< len(vertices) - 1:
    let vertex1 = vertices[i]
    let vertex2 = if i == len(vertices) - 1: vertices[0] else: vertices[i + 1]
    
    doubleArea += (vertex1[0]*vertex2[1] - vertex1[1]*vertex2[0])

let innerArea = doubleArea/2

let innerPoints = abs(innerArea) - (exteriorPoints/2) + 1
echo int(innerPoints) + exteriorPoints