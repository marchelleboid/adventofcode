import strformat
import strutils
import tables

type
    Instruction = object
        opCode: int
        firstMode: char
        secondMode: char
        thirdMode: char

proc initInstruction(instruction: int): Instruction =
    let instructionString = $instruction
    var opCode = ($instructionString[^1]).parseInt
    var firstMode, secondMode, thirdMode = '0'
    case instructionString.len:
        of 5:
            firstMode = instructionString[2]
            secondMode = instructionString[1]
            thirdMode = instructionString[0]
            opCode = instructionString[^2 .. ^1].parseInt
        of 4:
            firstMode = instructionString[1]
            secondMode = instructionString[0]
            opCode = instructionString[^2 .. ^1].parseInt
        of 3:
            firstMode = instructionString[0]
            opCode = instructionString[^2 .. ^1].parseInt
        of 2:
            opCode = instructionString[^2 .. ^1].parseInt
        else: discard
    Instruction(
        opCode: opCode,
        firstMode: firstMode,
        secondMode: secondMode,
        thirdMode: thirdMode)

type 
    IntCodeComputer* = object
        index: int
        memory: Table[int, int]
        inputFunction: proc(): int
        outputFunction: proc(output: int)
        relativeBase: int

proc initMemory(memory: seq[int]): Table[int, int] =
    for i, val in memory:
        result[i] = val

proc initComputer*(memory: seq[int]): IntCodeComputer =
    result.index = 0
    result.memory = initMemory(memory)
    result.relativeBase = 0

proc initComputer*(memory: seq[int], inputFunction: proc(): int, outputFunction: proc(output: int)): IntCodeComputer =
    result.index = 0
    result.memory = initMemory(memory)
    result.inputFunction = inputFunction
    result.outputFunction = outputFunction
    result.relativeBase = 0

proc setNounAndVerb*(self: var IntCodeComputer, noun, verb: int) =
    self.memory[1] = noun
    self.memory[2] = verb

proc getMemoryValue*(self: IntCodeComputer, address: int): int =
    self.memory.getOrDefault(address)

proc setMemoryValue(self: var IntCodeComputer, address: int, value: int, mode: char) =
    if mode == '0':
        self.memory[address] = value
    elif mode == '2':
        self.memory[self.relativeBase + address] = value

proc getValue(self: IntCodeComputer, mode: char, offset: int): int =
    var value = self.memory.getOrDefault(self.index + offset)
    if mode == '0':
        value = self.memory.getOrDefault(value)
    elif mode == '2':
        value = self.memory.getOrDefault(self.relativeBase + value)
    return value

proc handleOperation(self: var IntCodeComputer, firstMode, secondMode, thirdMode: char,
                     operation: proc(x, y: int): int) =
    let value1 = self.getValue(firstMode, 1)
    let value2 = self.getValue(secondMode, 2)

    let address = self.memory[self.index + 3]
    self.setMemoryValue(address, operation(value1, value2), thirdMode)
    self.index += 4

proc handleInput(self: var IntCodeComputer, firstMode: char) =
    let address = self.memory[self.index + 1]
    self.setMemoryValue(address, self.inputFunction(), firstMode)
    self.index += 2

proc handleOutput(self: var IntCodeComputer, firstMode: char) =
    let output = self.getValue(firstMode, 1)
    self.outputFunction(output)
    self.index += 2

proc handleJump(self: var IntCodeComputer, firstMode: char, secondMode: char,
                comparison: proc(x: int): bool) =
    let value1 = self.getValue(firstMode, 1)
    let value2 = self.getValue(secondMode, 2)
    if comparison(value1):
        self.index = value2
    else:
        self.index += 3

proc handleComparison(self: var IntCodeComputer, firstMode, secondMode, thirdMode: char,
                      comparison: proc(x, y: int): bool) =
    let value1 = self.getValue(firstMode, 1)
    let value2 = self.getValue(secondMode, 2)
    let address = self.memory[self.index + 3]
    if comparison(value1, value2):
        self.setMemoryValue(address, 1, thirdMode)
    else:
        self.setMemoryValue(address, 0, thirdMode)
    self.index += 4

proc handleRelativeBaseUpdate(self: var IntCodeComputer, firstMode: char) =
    let value = self.getValue(firstMode, 1)
    self.relativeBase = self.relativeBase + value
    self.index += 2

proc runProgram*(self: var IntCodeComputer) =
    while true:
        let instruction = initInstruction(self.memory[self.index])
        case instruction.opCode:
            of 1: # add
                self.handleOperation(instruction.firstMode, instruction.secondMode, instruction.thirdMode,
                                     proc (x, y: int): int = x + y)
            of 2: # multiply
                self.handleOperation(instruction.firstMode, instruction.secondMode, instruction.thirdMode,
                                     proc (x, y: int): int = x * y)
            of 3: # input
                self.handleInput(instruction.firstMode)
            of 4: # output
                self.handleOutput(instruction.firstMode)
            of 5: # jump if true
                self.handleJump(instruction.firstMode, instruction.secondMode,
                                proc (x: int): bool = x != 0)
            of 6: # jump if false
                self.handleJump(instruction.firstMode, instruction.secondMode,
                                proc (x: int): bool = x == 0)
            of 7: # less than
                self.handleComparison(instruction.firstMode, instruction.secondMode, instruction.thirdMode,
                                      proc (x, y: int): bool = x < y)
            of 8: # equals
                self.handleComparison(instruction.firstMode, instruction.secondMode, instruction.thirdMode,
                                      proc (x, y: int): bool = x == y)
            of 9: # update relative base
                self.handleRelativeBaseUpdate(instruction.firstMode)
            of 99: # halt
                break
            else:
                raise newException(ValueError, fmt"Unknown opCode {instruction.opCode}")
