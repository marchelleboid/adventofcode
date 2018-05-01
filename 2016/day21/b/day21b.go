package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func findInPassword(password []string, letter string) int {
	for i, c := range password {
		if c == letter {
			return i
		}
	}
	panic(fmt.Sprintf("can't find %s in %s", letter, password))
}

func rotateLeft(password []string, x int) []string {
	x = x % len(password)
	newFront, newBack := password[x:], password[:x]
	return append(newFront, newBack...)
}

func rotateRight(password []string, x int) []string {
	x = x % len(password)
	return rotateLeft(password, len(password)-x)
}

func main() {
	password := []string{"f", "b", "g", "d", "c", "e", "a", "h"}
	fileHandle, _ := os.Open("../input")
	defer fileHandle.Close()

	lines := make([]string, 0)
	fileScanner := bufio.NewScanner(fileHandle)
	for fileScanner.Scan() {
		lines = append(lines, fileScanner.Text())
	}
	for i, j := 0, len(lines)-1; i < j; i, j = i+1, j-1 {
		lines[i], lines[j] = lines[j], lines[i]
	}
	for _, line := range lines {
		splitLine := strings.Split(line, " ")
		if strings.HasPrefix(line, "swap position") {
			x, _ := strconv.Atoi(splitLine[2])
			y, _ := strconv.Atoi(splitLine[5])
			password[x], password[y] = password[y], password[x]
		} else if strings.HasPrefix(line, "swap letter") {
			x := findInPassword(password, splitLine[2])
			y := findInPassword(password, splitLine[5])
			password[x], password[y] = password[y], password[x]
		} else if strings.HasPrefix(line, "rotate based") {
			x := findInPassword(password, splitLine[6])
			leftRotation := 0
			switch x {
			case 0:
				leftRotation = 9
			case 1:
				leftRotation = 1
			case 2:
				leftRotation = 6
			case 3:
				leftRotation = 2
			case 4:
				leftRotation = 7
			case 5:
				leftRotation = 3
			case 6:
				leftRotation = 8
			case 7:
				leftRotation = 4
			}
			password = rotateLeft(password, leftRotation)
		} else if strings.HasPrefix(line, "rotate") {
			x, _ := strconv.Atoi(splitLine[2])
			if splitLine[1] == "right" {
				password = rotateLeft(password, x)
			} else {
				password = rotateRight(password, x)
			}
		} else if strings.HasPrefix(line, "reverse") {
			x, _ := strconv.Atoi(splitLine[2])
			y, _ := strconv.Atoi(splitLine[4])
			for i, j := x, y; i < j; i, j = i+1, j-1 {
				password[i], password[j] = password[j], password[i]
			}
		} else if strings.HasPrefix(line, "move") {
			y, _ := strconv.Atoi(splitLine[2])
			x, _ := strconv.Atoi(splitLine[5])
			character := password[x]
			password = append(password[:x], password[x+1:]...)
			password = append(password[:y], append([]string{character}, password[y:]...)...)
		}
	}
	fmt.Println(strings.Join(password, ""))
}
