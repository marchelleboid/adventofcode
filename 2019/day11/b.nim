import sequtils
import strutils
import tables
import ../intcode/computer

type
  Facing = enum
    up, down, right, left

var colorGrid: Table[(int, int), int]
var positionX = 0
var positionY = 0
var facing = up
var firstOutput = true

var mostLeft = 0
var mostRight = 0
var mostUp = 0
var mostDown = 0

colorGrid[(0, 0)] = 1

let program = map(readFile("input").strip().split(","), parseInt)
let inputFunction = proc(): int =
    return colorGrid.getOrDefault((positionX, positionY), 0)
let outputFunction = proc(output: int) =
    if firstOutput:
        colorGrid[(positionX, positionY)] = output
        firstOutput = false
    else:
        case facing:
            of up:
                if output == 0:
                    facing = left
                    positionX -= 1
                else:
                    facing = right
                    positionX += 1
            of down:
                if output == 0:
                    facing = right
                    positionX += 1
                else:
                    facing = left
                    positionX -= 1
            of right:
                if output == 0:
                    facing = up
                    positionY += 1
                else:
                    facing = down
                    positionY -= 1
            of left:
                if output == 0:
                    facing = down
                    positionY -= 1
                else:
                    facing = up
                    positionY += 1
        mostLeft = min(mostLeft, positionX)
        mostRight = max(mostRight, positionX)
        mostDown = min(mostDown, positionY)
        mostUp = max(mostUp, positionY)
        firstOutput = true

var intCodeComputer: IntCodeComputer = initComputer(program, inputFunction, outputFunction)
intCodeComputer.runProgram

for y in countdown(mostUp, mostDown):
    for x in countUp(mostLeft, mostRight):
        if colorGrid.getOrDefault((x, y), 0) == 0:
            stdout.write " "
        else:
            stdout.write "*"
    stdout.write "\n"
