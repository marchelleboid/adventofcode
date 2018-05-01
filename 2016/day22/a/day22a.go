package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type node struct {
	used      int
	available int
}

func main() {
	fileHandle, _ := os.Open("../input")
	defer fileHandle.Close()

	grid := make([][]node, 37)
	for i := 0; i < len(grid); i++ {
		grid[i] = make([]node, 25)
	}

	x, y := 0, 0
	fileScanner := bufio.NewScanner(fileHandle)
	for fileScanner.Scan() {
		fields := strings.Fields(fileScanner.Text())
		used, available := fields[2], fields[3]
		usedInt, _ := strconv.Atoi(used[:len(used)-1])
		availableInt, _ := strconv.Atoi(available[:len(available)-1])

		grid[x][y] = node{usedInt, availableInt}
		y++
		if y == 25 {
			y = 0
			x++
		}
	}
	count := 0
	for i0 := 0; i0 < len(grid); i0++ {
		for j0 := 0; j0 < len(grid[i0]); j0++ {
			currentNode := grid[i0][j0]
			if currentNode.used == 0 {
				continue
			}
			for i1 := 0; i1 < len(grid); i1++ {
				for j1 := 0; j1 < len(grid[i1]); j1++ {
					if i0 == i1 && j0 == j1 {
						continue
					}
					if currentNode.used <= grid[i1][j1].available {
						count++
					}
				}
			}
		}
	}
	fmt.Println(count)
}
