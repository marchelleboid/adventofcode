package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func executeProgram(a int, instructions []string) string {
	var buffer bytes.Buffer

	registers := make(map[string]int)
	registers["a"] = a
	registers["b"] = 0
	registers["c"] = 0
	registers["d"] = 0

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
		} else if command == "out" {
			value := splitLine[1]
			register1Value, prs := registers[value]
			output := ""
			if prs {
				output = strconv.Itoa(register1Value)
			} else {
				output = value
			}
			buffer.WriteString(output)
			if buffer.Len() >= 20 {
				break
			}
			pointer++
		}
	}

	return buffer.String()
}

func main() {
	content, _ := ioutil.ReadFile("../input")
	instructions := strings.Split(string(content), "\n")

	target := "01010101010101010101"

	i := 0
	for true {
		result := executeProgram(i, instructions)
		if result == target {
			break
		}
		i++
	}
	fmt.Println(i)
}
