import sequtils
import strutils
import ../intcode/computer

let program = map(readFile("input").strip().split(","), parseInt)
var intCodeComputer: IntCodeComputer = initComputer(program)
intCodeComputer.setNounAndVerb(12, 2)
intCodeComputer.runProgram
echo intCodeComputer.getMemoryValue(0)