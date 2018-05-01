package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

type position struct {
	x int
	y int
}

type path struct {
	steps int
	x     int
	y     int
}

func hasNotBeenVisited(x int, y int, visited map[position]bool) bool {
	_, prs := visited[position{x, y}]
	return !prs
}

func getNextPaths(currentPath path, visited map[position]bool, ductMap []string) []path {
	nextPaths := make([]path, 0)
	x := currentPath.x
	y := currentPath.y

	if ductMap[y+1][x] != '#' {
		if hasNotBeenVisited(x, y+1, visited) {
			nextPaths = append(nextPaths, path{currentPath.steps + 1, x, y + 1})
			visited[position{x, y + 1}] = true
		}
	}

	if ductMap[y-1][x] != '#' {
		if hasNotBeenVisited(x, y-1, visited) {
			nextPaths = append(nextPaths, path{currentPath.steps + 1, x, y - 1})
			visited[position{x, y - 1}] = true
		}
	}

	if ductMap[y][x+1] != '#' {
		if hasNotBeenVisited(x+1, y, visited) {
			nextPaths = append(nextPaths, path{currentPath.steps + 1, x + 1, y})
			visited[position{x + 1, y}] = true
		}
	}

	if ductMap[y][x-1] != '#' {
		if hasNotBeenVisited(x-1, y, visited) {
			nextPaths = append(nextPaths, path{currentPath.steps + 1, x - 1, y})
			visited[position{x - 1, y}] = true
		}
	}

	return nextPaths
}

func calculateDistance(shortestDistance *int, distance int, visited []byte, shortestPaths map[byte]map[byte]int) {
	if len(visited) == len(shortestPaths) {
		if distance < *shortestDistance {
			*shortestDistance = distance
		}
		return
	}

	distances := shortestPaths[visited[len(visited)-1]]
	for k := range distances {
		alreadyVisited := false
		for _, v := range visited {
			if v == k {
				alreadyVisited = true
				break
			}
		}
		if !alreadyVisited {
			newVisited := append([]byte(nil), visited...)
			newVisited = append(newVisited, k)
			calculateDistance(shortestDistance, distance+distances[k], newVisited, shortestPaths)
		}
	}
}

func main() {
	content, _ := ioutil.ReadFile("../input")
	ductMap := strings.Split(string(content), "\n")

	height := len(ductMap)
	width := len(ductMap[0])

	numberLocations := make(map[byte]position)

	for x := 0; x < width; x++ {
		for y := 0; y < height; y++ {
			character := ductMap[y][x]
			if character != '#' && character != '.' {
				numberLocations[character] = position{x, y}
			}
		}
	}

	shortestPaths := make(map[byte]map[byte]int)
	for k := range numberLocations {
		shortestPaths[k] = make(map[byte]int)
	}

	for k := range shortestPaths {
		queue := make([]path, 0)
		queue = append(queue, path{0, numberLocations[k].x, numberLocations[k].y})
		visited := make(map[position]bool)
		visited[numberLocations[k]] = true
		for len(shortestPaths[k]) < len(shortestPaths)-1 {
			currentPath := queue[0]
			queue = queue[1:]
			nextPaths := getNextPaths(currentPath, visited, ductMap)
			for _, nextPath := range nextPaths {
				character := ductMap[nextPath.y][nextPath.x]
				if character != '.' {
					_, prs := shortestPaths[k][character]
					if !prs {
						shortestPaths[k][character] = nextPath.steps
						shortestPaths[character][k] = nextPath.steps
						if len(shortestPaths[k]) == len(shortestPaths)-1 {
							break
						}
					}
				}
				queue = append(queue, nextPath)
			}
		}
	}

	shortestDistance := 9999999999
	visited := make([]byte, 0)
	visited = append(visited, "0"[0])
	calculateDistance(&shortestDistance, 0, visited, shortestPaths)
	fmt.Println(shortestDistance)
}
