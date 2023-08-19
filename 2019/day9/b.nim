import sequtils
import strutils
import ../intcode/computer

let program = map(readFile("input").strip().split(","), parseInt)
let inputFunction = proc(): int = 2
let outputFunction = proc(output: int) = echo output
var intCodeComputer: IntCodeComputer = initComputer(program, inputFunction, outputFunction)
intCodeComputer.runProgram
