package main

import (
	"crypto/md5"
	"encoding/hex"
	"fmt"
)

type position struct {
	passcode string
	x        int
	y        int
}

func calculateNextMoves(currentPosition position) []position {
	newPositions := make([]position, 0)

	hashFunction := md5.New()
	hashFunction.Write([]byte(currentPosition.passcode))
	hashOutput := hex.EncodeToString(hashFunction.Sum(nil))

	if currentPosition.y != 0 && hashOutput[0] > 'a' {
		newPositions = append(newPositions,
			position{currentPosition.passcode + "U",
				currentPosition.x, currentPosition.y - 1})
	}
	if currentPosition.y != 3 && hashOutput[1] > 'a' {
		newPositions = append(newPositions,
			position{currentPosition.passcode + "D",
				currentPosition.x, currentPosition.y + 1})
	}
	if currentPosition.x != 0 && hashOutput[2] > 'a' {
		newPositions = append(newPositions,
			position{currentPosition.passcode + "L",
				currentPosition.x - 1, currentPosition.y})
	}
	if currentPosition.x != 3 && hashOutput[3] > 'a' {
		newPositions = append(newPositions,
			position{currentPosition.passcode + "R",
				currentPosition.x + 1, currentPosition.y})
	}

	return newPositions
}

func main() {
	passcode := "vwbaicqe"
	queue := make([]position, 0)
	queue = append(queue, position{passcode, 0, 0})
	longestPath := 0
	for len(queue) > 0 {
		currentPosition := queue[0]
		queue = queue[1:]
		newPositions := calculateNextMoves(currentPosition)
		for _, newPosition := range newPositions {
			if newPosition.x == 3 && newPosition.y == 3 {
				length := len(newPosition.passcode) - len(passcode)
				if length > longestPath {
					longestPath = length
				}
				continue
			}
			queue = append(queue, newPosition)
		}
	}
	fmt.Println(longestPath)
}
