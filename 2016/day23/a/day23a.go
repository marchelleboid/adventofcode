package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	registers := make(map[string]int)
	registers["a"] = 7
	registers["b"] = 0
	registers["c"] = 0
	registers["d"] = 0

	content, _ := ioutil.ReadFile("../input")
	instructions := strings.Split(string(content), "\n")

	pointer := 0
	for pointer < len(instructions) {
		instruction := instructions[pointer]
		splitLine := strings.Split(instruction, " ")
		command := splitLine[0]
		if command == "cpy" {
			value := splitLine[1]
			register2 := splitLine[2]
			register1Value, prs := registers[value]
			if prs {
				registers[register2] = register1Value
			} else {
				valueInt, _ := strconv.Atoi(value)
				registers[register2] = valueInt
			}
			pointer++
		} else if command == "inc" {
			register := splitLine[1]
			registers[register] = registers[register] + 1
			pointer++
		} else if command == "dec" {
			register := splitLine[1]
			registers[register] = registers[register] - 1
			pointer++
		} else if command == "jnz" {
			jumpValue := splitLine[2]
			jumpValueInt := 0
			register2Value, prs := registers[jumpValue]
			if prs {
				jumpValueInt = register2Value
			} else {
				jumpValueInt, _ = strconv.Atoi(jumpValue)
			}
			value := splitLine[1]
			register1Value, prs := registers[value]
			valueInt := 0
			if prs {
				valueInt = register1Value
			} else {
				valueInt, _ = strconv.Atoi(value)
			}
			if valueInt != 0 {
				pointer += jumpValueInt
			} else {
				pointer++
			}
		} else if command == "tgl" {
			value := splitLine[1]
			instructionPointerToToggle := 0
			registerValue, prs := registers[value]
			if prs {
				instructionPointerToToggle = pointer + registerValue
			} else {
				intValue, _ := strconv.Atoi(value)
				instructionPointerToToggle = pointer + intValue
			}
			if instructionPointerToToggle < len(instructions) {
				oldInstruction := instructions[instructionPointerToToggle]
				oldInstructionSplit := strings.Split(oldInstruction, " ")
				oldCommand := oldInstructionSplit[0]
				var newInstruction []string
				if oldCommand == "inc" {
					newInstruction = []string{"dec", oldInstructionSplit[1]}
				} else if oldCommand == "dec" || oldCommand == "tgl" {
					newInstruction = []string{"inc", oldInstructionSplit[1]}
				} else if oldCommand == "cpy" {
					newInstruction = []string{"jnz", oldInstructionSplit[1], oldInstructionSplit[2]}
				} else if oldCommand == "jnz" {
					newInstruction = []string{"cpy", oldInstructionSplit[1], oldInstructionSplit[2]}
				}
				instructions[instructionPointerToToggle] = strings.Join(newInstruction, " ")
			}
			pointer++
		}
	}

	fmt.Println(registers["a"])
}
