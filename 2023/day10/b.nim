import sugar

var startX, startY: int
var startFound = false
var rowCount = 0
var grid = collect:
    for line in lines("input.txt"):
        if not startFound:
            for i, c in line:
                if c == 'S':
                    startX = i
                    startY = rowCount
                    startFound = true
                    break
            rowCount += 1
        line

var canGoUp, canGoRight, canGoLeft, canGoDown = false
if @['|', 'F', '7'].contains(grid[startY - 1][startX]):
    canGoUp = true
if @['-', 'J', '7'].contains(grid[startY][startX + 1]):
    canGoRight = true
if @['-', 'L', 'F'].contains(grid[startY][startX - 1]):
    canGoLeft = true
if @['|', 'L', 'J'].contains(grid[startY + 1][startX]):
    canGoDown = true

var actualS: char
if canGoUp and canGoDown:
    actualS = '|'
elif canGoUp and canGoRight:
    actualS = 'L'
elif canGoUp and canGoLeft:
    actualS = 'J'
elif canGoDown and canGoRight:
    actualS = 'F'
elif canGoDown and canGoLeft:
    actualS = '7'
else:
    actualS = '-'

let numberOfColumns = len(grid[0])

var previousX, previousY = -1
var currentX = startX
var currentY = startY

# var boundaryPoints: HashSet[(int, int)]
var vertices: seq[(int, int)]
var steps = 0
while true:
    let currentTile = grid[currentY][currentX]
    if currentTile == 'S' and @['L', 'J', '7', 'F'].contains(actualS):
        vertices.add((currentX, currentY))
    elif @['L', 'J', '7', 'F'].contains(currentTile):
        vertices.add((currentX, currentY))
    case currentTile:
        of '|':
            if previousY != currentY - 1:
                previousX = currentX
                previousY = currentY
                currentY -= 1
            else:
                previousX = currentX
                previousY = currentY
                currentY += 1
        of '-':
            if previousX != currentX - 1:
                previousX = currentX
                currentX -= 1
            else:
                previousX = currentX
                previousY = currentY
                currentX += 1
        of 'L':
            if previousY != currentY - 1:
                previousX = currentX
                previousY = currentY
                currentY -= 1
            else:
                previousX = currentX
                previousY = currentY
                currentX += 1
        of 'J':
            if previousY != currentY - 1:
                previousX = currentX
                previousY = currentY
                currentY -= 1
            else:
                previousX = currentX
                previousY = currentY
                currentX -= 1
        of '7':
            if previousY != currentY + 1:
                previousX = currentX
                previousY = currentY
                currentY += 1
            else:
                previousX = currentX
                previousY = currentY
                currentX -= 1
        of 'F':
            if previousY != currentY + 1:
                previousX = currentX
                previousY = currentY
                currentY += 1
            else:
                previousX = currentX
                previousY = currentY
                currentX += 1
        of 'S':
            if currentY != 0 and @['|', 'F', '7'].contains(grid[currentY - 1][currentX]):
                previousY = currentY
                previousX = currentX
                currentY -= 1
            elif currentX != numberOfColumns - 1 and @['-', 'J', '7'].contains(grid[currentY][currentX + 1]):
                previousY = currentY
                previousX = currentX
                currentX += 1
            elif currentX != 0 and @['-', 'L', 'F'].contains(grid[currentY][currentX - 1]):
                previousY = currentY
                previousX = currentX
                currentX -= 1
            else:
                previousY = currentY
                previousX = currentX
                currentY += 1
        else:
            echo "oops"
            break

    steps += 1

    if grid[currentY][currentX] == 'S':
        break

var doubleArea = 0
for i in 0 ..< len(vertices):
    let vertex1 = vertices[i]
    let vertex2 = if i == len(vertices) - 1: vertices[0] else: vertices[i + 1]
    
    doubleArea += (vertex1[0]*vertex2[1] - vertex1[1]*vertex2[0])

let innerArea = doubleArea/2

let innerPoints = abs(innerArea) - (steps/2) + 1
echo innerPoints
