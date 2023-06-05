import algorithm
import deques
import sequtils
import strutils
import ../intcode/computer

let program = map(readFile("input").strip().split(","), parseInt)
var phases = @[0, 1, 2, 3, 4]
var maxThrust = low(int)
while true:
    var nextInput = 0
    for phase in phases:
        var inputDeque = @[phase, nextInput].toDeque
        let inputFunction = proc(): int = inputDeque.popFirst
        let outputFunction = proc(output: int) = nextInput = output
        var intCodeComputer: IntCodeComputer = initComputer(program, inputFunction, outputFunction)
        intCodeComputer.runProgram
        maxThrust = max(maxThrust, nextInput)

    if not phases.nextPermutation():
        break

echo maxThrust
