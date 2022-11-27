import strformat
import strutils

type
    Instruction = object
        opCode: int
        firstImmediate: bool
        secondImmediate: bool
        thirdImmediate: bool

proc initInstruction(instruction: int): Instruction =
    let instructionString = $instruction
    var opCode = ($instructionString[^1]).parseInt
    var firstImmediate, secondImmediate, thirdImmediate = false
    case instructionString.len:
        of 5:
            firstImmediate = instructionString[2] == '1'
            secondImmediate = instructionString[1] == '1'
            thirdImmediate = instructionString[0] == '1'
            opCode = instructionString[^2 .. ^1].parseInt
        of 4:
            firstImmediate = instructionString[1] == '1'
            secondImmediate = instructionString[0] == '1'
            opCode = instructionString[^2 .. ^1].parseInt
        of 3:
            firstImmediate = instructionString[0] == '1'
            opCode = instructionString[^2 .. ^1].parseInt
        of 2:
            opCode = instructionString[^2 .. ^1].parseInt
        else: discard
    Instruction(
        opCode: opCode,
        firstImmediate: firstImmediate,
        secondImmediate: secondImmediate,
        thirdImmediate: thirdImmediate)

type 
    IntCodeComputer* = object
        index: int
        memory: seq[int]
        inputFunction: proc(): int
        outputFunction: proc(output: int)

proc initComputer*(memory: seq[int]): IntCodeComputer =
    result.index = 0
    result.memory = memory

proc initComputer*(memory: seq[int], inputFunction: proc(): int, outputFunction: proc(output: int)): IntCodeComputer =
    result.index = 0
    result.memory = memory
    result.inputFunction = inputFunction
    result.outputFunction = outputFunction

proc setNounAndVerb*(self: var IntCodeComputer, noun, verb: int) =
    self.memory[1] = noun
    self.memory[2] = verb

proc getMemoryValue*(self: IntCodeComputer, address: int): int =
    self.memory[address]

proc getValue(self: IntCodeComputer, immediate: bool, offset: int): int =
    var value = self.memory[self.index + offset]
    if not immediate:
        value = self.memory[value]
    return value

proc handleOperation(self: var IntCodeComputer, firstImmediate: bool, secondImmediate: bool,
                     operation: proc(x, y: int): int) =
    let value1 = self.getValue(firstImmediate, 1)
    let value2 = self.getValue(secondImmediate, 2)

    let address = self.memory[self.index + 3]
    self.memory[address] = operation(value1, value2)
    self.index += 4

proc handleInput(self: var IntCodeComputer) =
    let address = self.memory[self.index + 1]
    self.memory[address] = self.inputFunction()
    self.index += 2

proc handleOutput(self: var IntCodeComputer, firstImmediate: bool) =
    let output = self.getValue(firstImmediate, 1)
    self.outputFunction(output)
    self.index += 2

proc handleJump(self: var IntCodeComputer, firstImmediate: bool, secondImmediate: bool,
                comparison: proc(x: int): bool) =
    let value1 = self.getValue(firstImmediate, 1)
    let value2 = self.getValue(secondImmediate, 2)
    if comparison(value1):
        self.index = value2
    else:
        self.index += 3

proc handleComparison(self: var IntCodeComputer, firstImmediate: bool, secondImmediate: bool,
                      comparison: proc(x, y: int): bool) =
    let value1 = self.getValue(firstImmediate, 1)
    let value2 = self.getValue(secondImmediate, 2)
    let address = self.memory[self.index + 3]
    if comparison(value1, value2):
        self.memory[address] = 1
    else:
        self.memory[address] = 0
    self.index += 4

proc runProgram*(self: var IntCodeComputer) =
    while true:
        let instruction = initInstruction(self.memory[self.index])
        case instruction.opCode:
            of 1: # add
                self.handleOperation(instruction.firstImmediate, instruction.secondImmediate, 
                                     proc (x, y: int): int = x + y)
            of 2: # multiply
                self.handleOperation(instruction.firstImmediate, instruction.secondImmediate, 
                                     proc (x, y: int): int = x * y)
            of 3: # input
                self.handleInput()
            of 4: # output
                self.handleOutput(instruction.firstImmediate)
            of 5: # jump if true
                self.handleJump(instruction.firstImmediate, instruction.secondImmediate,
                                proc (x: int): bool = x != 0)
            of 6: # jump if false
                self.handleJump(instruction.firstImmediate, instruction.secondImmediate,
                                proc (x: int): bool = x == 0)
            of 7: # less than
                self.handleComparison(instruction.firstImmediate, instruction.secondImmediate,
                                      proc (x, y: int): bool = x < y)
            of 8: # equals
                self.handleComparison(instruction.firstImmediate, instruction.secondImmediate,
                                      proc (x, y: int): bool = x == y)
            of 99: # halt
                break
            else:
                raise newException(ValueError, fmt"Unknown opCode {instruction.opCode}")