package main

import (
	"fmt"
)

func main() {
	players := make([]int, 3014387)
	for i := 0; i < len(players); i++ {
		if i == len(players)-1 {
			players[i] = 0
		} else {
			players[i] = i + 1
		}
	}

	position := 0
	alive := len(players)
	beforeRemovalPosition := alive/2 - 1
	for alive > 1 {
		removalPosition := players[beforeRemovalPosition]
		players[beforeRemovalPosition] = players[removalPosition]
		alive--
		if alive == 1 {
			break
		}
		position = players[position]
		if alive%2 == 0 {
			beforeRemovalPosition = players[beforeRemovalPosition]
		}
	}
	fmt.Println(position + 1)
}
