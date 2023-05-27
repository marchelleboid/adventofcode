import strutils

let sideLength = 50

proc whichSide(x, y: int): int =
    let xDiv = int(x/sideLength)
    let yDiv = int(y/sideLength)
    if yDiv == 0:
        if xDiv == 1:
            return 1
        elif xDiv == 2:
            return 2
    elif yDiv == 1:
        return 3
    elif yDiv == 2:
        if xDiv == 0:
            return 4
        elif xDiv == 1:
            return 5
    elif yDiv == 3:
        return 6
    else:
        echo "nope"
        return -1

var grid: seq[string]
var instructions: string
var readingGrid = true
for line in lines("input"):
    if line.isEmptyOrWhitespace:
        readingGrid = false
    else:
        if readingGrid:
            grid.add(line)
        else:
            instructions = line

var facing = 0
var x = sideLength
var y = 0

var current: string
for i in 0 .. instructions.len:
    let c = if i == instructions.len: 'X' else: instructions[i]
    if c == 'R' or c == 'L' or c == 'X':
        var toMove = parseInt(current)
        current = ""

        while toMove > 0:
            let currentSide = whichSide(x, y)
            var newX = x
            var newY = y
            var newFacing = facing
            case facing:
                of 0:
                    if currentSide == 2 and x == 3*sideLength - 1:
                        newX = 2*sideLength - 1
                        newY = 2*sideLength + (sideLength - 1) - y
                        newFacing = 2
                    elif currentSide == 3 and x == 2*sideLength - 1:
                        newX = 2*sideLength + y - sideLength
                        newY = sideLength - 1
                        newFacing = 3
                    elif currentSide == 5 and x == 2*sideLength - 1:
                        newX = 3*sideLength - 1
                        newY = 3*sideLength - 1 - y
                        newFacing = 2
                    elif currentSide == 6 and x == sideLength - 1:
                        newX = sideLength + y - 3*sideLength
                        newY = 3*sideLength - 1
                        newFacing = 3
                    else:
                        newX = x + 1
                of 1:
                    if currentSide == 2 and y == sideLength - 1:
                        newX = 2*sideLength - 1
                        newY = sideLength + x - 2*sideLength
                        newFacing = 2
                    elif currentSide == 5 and y == 3*sideLength - 1:
                        newX = sideLength - 1
                        newY = 3*sideLength + x - sideLength
                        newFacing = 2
                    elif currentSide == 6 and y == 4*sideLength - 1:
                        newX = 2*sideLength + x
                        newY = 0
                        newFacing = 1
                    else:
                        newY = y + 1
                of 2:
                    if currentSide == 1 and x == sideLength:
                        newX = 0
                        newY = 2*sideLength + sideLength - 1 - y
                        newFacing = 0
                    elif currentSide == 3 and x == sideLength:
                        newX = y - sideLength
                        newY = 2*sideLength
                        newFacing = 1
                    elif currentSide == 4 and x == 0:
                        newX = sideLength
                        newY = 3*sideLength - 1 - y
                        newFacing = 0
                    elif currentSide == 6 and x == 0:
                        newX = sideLength + y - 3*sideLength
                        newY = 0
                        newFacing = 1
                    else:
                        newX = x - 1
                of 3:
                    if currentSide == 1 and y == 0:
                        newX = 0
                        newY = 3*sideLength + x - sideLength
                        newFacing = 0
                    elif currentSide == 2 and y == 0:
                        newX = x - 2*sideLength
                        newY = 4*sideLength - 1
                        newFacing = 3
                    elif currentSide == 4 and y == 2*sideLength:
                        newX = sideLength
                        newY = sideLength + x
                        newFacing = 0
                    else:
                        newY = y - 1
                else:
                    echo "oops!"
            
            if grid[newY][newX] == '#':
                break
            x = newX
            y = newY
            facing = newFacing
            toMove -= 1
        
        if c == 'R':
            facing += 1
            if facing == 4:
                facing = 0
        if c == 'L':
            facing -= 1
            if facing == -1:
                facing = 3
    else:
        current.add(c)

let finalScore = 1000*(y + 1) + 4*(x + 1) + facing
echo finalScore
