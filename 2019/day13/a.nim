import sequtils
import strutils
import ../intcode/computer

let program = map(readFile("input").strip().split(","), parseInt)
let inputFunction = proc(): int = 0 # not needed
var outputCounter = 0
var blockTiles = 0
let outputFunction = proc(output: int) =
    if outputCounter == 2 and output == 2:
        blockTiles += 1
    outputCounter += 1
    if outputCounter == 3:
        outputCounter = 0
var intCodeComputer: IntCodeComputer = initComputer(program, inputFunction, outputFunction)
intCodeComputer.runProgram

echo blockTiles
