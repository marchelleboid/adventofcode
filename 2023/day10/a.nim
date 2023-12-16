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

let numberOfColumns = len(grid[0])

var previousX, previousY = -1
var currentX = startX
var currentY = startY

var steps = 0
while true:
    let currentTile = grid[currentY][currentX]
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

echo int(steps / 2)
