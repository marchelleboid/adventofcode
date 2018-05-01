package main

import (
	"fmt"
	"strings"
)

func getNextRow(previousRow string) string {
	newRow := make([]byte, len(previousRow))
	for j := 0; j < len(newRow); j++ {
		center := string(previousRow[j])
		left := "."
		right := "."
		if j == 0 {
			right = string(previousRow[j+1])
		} else if j == len(newRow)-1 {
			left = string(previousRow[j-1])
		} else {
			left = string(previousRow[j-1])
			right = string(previousRow[j+1])
		}
		if (left == "^" && center == "^" && right == ".") ||
			(left == "." && center == "^" && right == "^") ||
			(left == "^" && center == "." && right == ".") ||
			(left == "." && center == "." && right == "^") {
			newRow[j] = byte('^')
		} else {
			newRow[j] = byte('.')
		}
	}
	return string(newRow)
}

func main() {
	previousRow := ".^.^..^......^^^^^...^^^...^...^....^^.^...^.^^^^....^...^^.^^^...^^^^.^^.^.^^..^.^^^..^^^^^^.^^^..^"

	safeCount := strings.Count(previousRow, ".")

	for i := 0; i < 399999; i++ {
		nextRow := getNextRow(previousRow)
		previousRow = nextRow
		safeCount += strings.Count(nextRow, ".")
	}

	fmt.Println(safeCount)
}
