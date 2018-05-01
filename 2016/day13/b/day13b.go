package main

import (
	"fmt"
	"strconv"
	"strings"
)

type position struct {
	x int
	y int
}

type path struct {
	currentPosition position
	path            map[position]bool
}

func isOpen(x int, y int) bool {
	sum := int64(x*x + 3*x + 2*x*y + y + y*y + 1362)
	binaryString := strconv.FormatInt(sum, 2)
	return strings.Count(binaryString, "1")%2 == 0
}

func validNewPosition(newPosition position, visited map[position]bool) bool {
	_, prs := visited[newPosition]
	if !prs {
		return isOpen(newPosition.x, newPosition.y)
	}
	return false
}

func copyMap(originalMap map[position]bool) map[position]bool {
	newMap := make(map[position]bool)
	for k, v := range originalMap {
		newMap[k] = v
	}
	return newMap
}

func calculateNextPaths(currentPath path) []path {
	newPaths := make([]path, 0)
	currentX, currentY := currentPath.currentPosition.x, currentPath.currentPosition.y
	visited := currentPath.path

	if currentY > 0 {
		up := position{currentX, currentY - 1}
		if validNewPosition(up, visited) {
			newVisited := copyMap(visited)
			newVisited[currentPath.currentPosition] = true
			newPaths = append(newPaths, path{up, newVisited})
		}
	}

	down := position{currentX, currentY + 1}
	if validNewPosition(down, visited) {
		newVisited2 := copyMap(visited)
		newVisited2[currentPath.currentPosition] = true
		newPaths = append(newPaths, path{down, newVisited2})
	}

	if currentX > 0 {
		left := position{currentX - 1, currentY}
		if validNewPosition(left, visited) {
			newVisited3 := copyMap(visited)
			newVisited3[currentPath.currentPosition] = true
			newPaths = append(newPaths, path{left, newVisited3})
		}
	}

	right := position{currentX + 1, currentY}
	if validNewPosition(right, visited) {
		newVisited4 := copyMap(visited)
		newVisited4[currentPath.currentPosition] = true
		newPaths = append(newPaths, path{right, newVisited4})
	}

	return newPaths
}

func main() {
	startingPoint := path{position{1, 1}, make(map[position]bool)}
	queue := make([]path, 0)
	queue = append(queue, startingPoint)
	visited := make(map[position]bool)
	for len(queue) > 0 {
		currentPath := queue[0]
		queue = queue[1:]

		if len(currentPath.path) > 50 {
			break
		}

		visited[currentPath.currentPosition] = true

		newPaths := calculateNextPaths(currentPath)
		for _, newPath := range newPaths {
			queue = append(queue, newPath)
		}
	}
	fmt.Println(len(visited))
}
