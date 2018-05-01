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
	password := []string{"a", "b", "c", "d", "e", "f", "g", "h"}
	fileHandle, _ := os.Open("../input")
	defer fileHandle.Close()

	fileScanner := bufio.NewScanner(fileHandle)
	for fileScanner.Scan() {
		line := fileScanner.Text()
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
			rotationAmount := x + 1
			if x >= 4 {
				rotationAmount++
			}
			password = rotateRight(password, rotationAmount)
		} else if strings.HasPrefix(line, "rotate") {
			x, _ := strconv.Atoi(splitLine[2])
			if splitLine[1] == "right" {
				password = rotateRight(password, x)
			} else {
				password = rotateLeft(password, x)
			}
		} else if strings.HasPrefix(line, "reverse") {
			x, _ := strconv.Atoi(splitLine[2])
			y, _ := strconv.Atoi(splitLine[4])
			for i, j := x, y; i < j; i, j = i+1, j-1 {
				password[i], password[j] = password[j], password[i]
			}
		} else if strings.HasPrefix(line, "move") {
			x, _ := strconv.Atoi(splitLine[2])
			y, _ := strconv.Atoi(splitLine[5])
			character := password[x]
			password = append(password[:x], password[x+1:]...)
			password = append(password[:y], append([]string{character}, password[y:]...)...)
		}
	}
	fmt.Println(strings.Join(password, ""))
}
