import sequtils
import strutils
import ../intcode/computer

let program = map(readFile("input").strip().split(","), parseInt)

for noun in countup(0, 99):
    for verb in countup(0, 99):
        var intCodeComputer: IntCodeComputer = initComputer(program)
        intCodeComputer.setNounAndVerb(noun, verb)
        intCodeComputer.runProgram
        if intCodeComputer.getMemoryValue(0) == 19690720:
            echo 100 * noun + verb
            break