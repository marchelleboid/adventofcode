import sequtils
import strutils
import ../intcode/computer

var program = map(readFile("input").strip().split(","), parseInt)
program[0] = 2

var lastX = 0
var lastY = 0
var ballX = 0
var paddleX = 0
var score = 0

let inputFunction = proc(): int =
    if ballX < paddleX:
        return -1
    elif ballX > paddleX:
        return 1
    else:
        return 0

var outputCounter = 0
let outputFunction = proc(output: int) =
    if outputCounter == 2:
        if lastX == -1 and lastY == 0:
            score = output
        elif output == 3:
            paddleX = lastX
        elif output == 4:
            ballX = lastX
    elif outputCounter == 0:
        lastX = output
    elif outputCounter == 1:
        lastY = output

    outputCounter += 1
    if outputCounter == 3:
        outputCounter = 0

var intCodeComputer: IntCodeComputer = initComputer(program, inputFunction, outputFunction)
intCodeComputer.runProgram

echo score
