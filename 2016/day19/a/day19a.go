package main

import (
	"fmt"
)

func main() {
	players := make([]int, 3014387)
	for i := 0; i < len(players); i++ {
		players[i] = i + 1
	}

	for len(players) > 3 {
		newPlayers := make([]int, 0)
		for i, player := range players {
			if i%2 == 0 {
				newPlayers = append(newPlayers, player)
			}
		}
		if len(players)%2 != 0 {
			newPlayers = newPlayers[1:]
		}
		players = newPlayers
	}
	if len(players) == 3 {
		fmt.Println(players[2])
	} else if len(players) == 2 {
		fmt.Println(players[0])
	}
}
