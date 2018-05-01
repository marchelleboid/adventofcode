package main

import (
	"bytes"
	"fmt"
	"strconv"
)

type Item struct {
	element     string
	isMicrochip bool
}

type State struct {
	steps    int
	elevator int
	floors   [4][]Item
}

type Pair struct {
	microchip int
	generator int
}

func getStateHash(state State) string {
	var buffer bytes.Buffer
	buffer.WriteString(strconv.Itoa(state.elevator))
	pairMap := getPairMap(state.floors)
	for key, value := range pairMap {
		buffer.WriteString(strconv.Itoa(key.microchip))
		buffer.WriteString(strconv.Itoa(key.generator))
		buffer.WriteString(strconv.Itoa(value))
	}
	return buffer.String()
}

func getPairMap(floors [4][]Item) map[Pair]int {
	pairMap := make(map[Pair]int)
	generators := make(map[string]int)
	for i := 0; i < 4; i++ {
		floor := floors[i]
		for _, item := range floor {
			if !item.isMicrochip {
				generators[item.element] = i
			}
		}
	}
	for i := 0; i < 4; i++ {
		floor := floors[i]
		for _, item := range floor {
			if item.isMicrochip {
				pair := Pair{i, generators[item.element]}
				val, prs := pairMap[pair]
				if prs {
					pairMap[pair] = val + 1
				} else {
					pairMap[pair] = 1
				}
			}
		}
	}
	return pairMap
}

func isValidFloor(floor []Item) bool {
	generators := make(map[string]bool)
	microchips := make(map[string]bool)
	for _, item := range floor {
		if item.isMicrochip {
			microchips[item.element] = true
		} else {
			generators[item.element] = true
		}
	}
	for microchip := range microchips {
		_, prs := generators[microchip]
		if !prs && len(generators) > 0 {
			return false
		}
	}
	return true
}

func canAddItem(itemToAdd Item, floor []Item) bool {
	floorCopy := append([]Item(nil), floor...)
	floorCopy = append(floorCopy, itemToAdd)
	return isValidFloor(floorCopy)
}

func canAddItems(itemToAdd1 Item, itemToAdd2 Item, floor []Item) bool {
	if itemToAdd1.element == itemToAdd2.element {
		return true
	}
	floorCopy := append([]Item(nil), floor...)
	floorCopy = append(floorCopy, itemToAdd1, itemToAdd2)
	return isValidFloor(floorCopy)
}

func canRemoveItem(i int, floor []Item) bool {
	if len(floor) == 1 {
		return true
	}
	floorCopy := append([]Item(nil), floor...)
	floorCopy = append(floorCopy[:i], floorCopy[i+1:]...)
	return isValidFloor(floorCopy)
}

func canRemoveItems(i int, j int, floor []Item) bool {
	if len(floor) == 2 {
		return true
	}
	floorCopy := append([]Item(nil), floor...)
	floorCopy = append(floorCopy[:i], floorCopy[i+1:]...)
	floorCopy = append(floorCopy[:j-1], floorCopy[j:]...)
	return isValidFloor(floorCopy)
}

func generateNextStates(currentState State, alreadyVisited map[string]bool) []State {
	nextStates := make([]State, 0)
	currentElevator := currentState.elevator
	currentFloor := currentState.floors[currentElevator]

	newElevators := make([]int, 0)

	if currentElevator == 1 && len(currentState.floors[0]) != 0 {
		newElevators = append(newElevators, currentElevator-1)
	} else if currentElevator == 2 && (len(currentState.floors[0]) != 0 || len(currentState.floors[1]) != 0) {
		newElevators = append(newElevators, currentElevator-1)
	} else if currentElevator == 3 {
		newElevators = append(newElevators, currentElevator-1)
	}

	if currentElevator < len(currentState.floors)-1 {
		newElevators = append(newElevators, currentElevator+1)
	}

	for _, newElevator := range newElevators {
		newFloor := currentState.floors[newElevator]

		for i := 0; i < len(currentFloor); i++ {
			item1 := currentFloor[i]
			if canAddItem(item1, newFloor) && canRemoveItem(i, currentFloor) {
				newState := State{steps: currentState.steps + 1,
					elevator: newElevator}
				newState.floors[0] = append([]Item(nil), currentState.floors[0]...)
				newState.floors[1] = append([]Item(nil), currentState.floors[1]...)
				newState.floors[2] = append([]Item(nil), currentState.floors[2]...)
				newState.floors[3] = append([]Item(nil), currentState.floors[3]...)
				currentFloorCopy := append([]Item(nil), currentFloor...)
				newFloorCopy := append([]Item(nil), newFloor...)
				newState.floors[currentElevator] = append(currentFloorCopy[:i], currentFloorCopy[i+1:]...)
				newState.floors[newElevator] = append(newFloorCopy, item1)
				stateHash := getStateHash(newState)
				_, prs := alreadyVisited[stateHash]
				if !prs {
					nextStates = append(nextStates, newState)
					alreadyVisited[stateHash] = true
				}
			}
			for j := i + 1; j < len(currentFloor); j++ {
				item2 := currentFloor[j]
				if canAddItems(item1, item2, newFloor) && canRemoveItems(i, j, currentFloor) {
					newState := State{steps: currentState.steps + 1,
						elevator: newElevator}
					newState.floors[0] = append([]Item(nil), currentState.floors[0]...)
					newState.floors[1] = append([]Item(nil), currentState.floors[1]...)
					newState.floors[2] = append([]Item(nil), currentState.floors[2]...)
					newState.floors[3] = append([]Item(nil), currentState.floors[3]...)
					currentFloorCopy := append([]Item(nil), currentFloor...)
					newFloorCopy := append([]Item(nil), newFloor...)
					newState.floors[currentElevator] = append(currentFloorCopy[:i], currentFloorCopy[i+1:]...)
					newState.floors[currentElevator] =
						append(newState.floors[currentElevator][:j-1],
							newState.floors[currentElevator][j:]...)
					newState.floors[newElevator] = append(newFloorCopy, item1, item2)
					stateHash := getStateHash(newState)
					_, prs := alreadyVisited[stateHash]
					if !prs {
						nextStates = append(nextStates, newState)
						alreadyVisited[stateHash] = true
					}
				}
			}
		}
	}

	return nextStates
}

func main() {
	initialState := State{steps: 0, elevator: 0}
	initialState.floors[0] = []Item{Item{"polonium", false}, Item{"thulium", false}, Item{"thulium", true},
		Item{"promethium", false}, Item{"ruthenium", false}, Item{"ruthenium", true},
		Item{"cobalt", false}, Item{"cobalt", true}, Item{"elerium", false}, Item{"elerium", true},
		Item{"dilithium", false}, Item{"dilithium", true}}
	initialState.floors[1] = []Item{Item{"polonium", true}, Item{"promethium", true}}
	initialState.floors[2] = make([]Item, 0)
	initialState.floors[3] = make([]Item, 0)

	queue := make([]State, 0)
	queue = append(queue, initialState)

	alreadyVisited := make(map[string]bool)

	for len(queue) > 0 {
		currentState := queue[0]
		queue = queue[1:]
		nextStates := generateNextStates(currentState, alreadyVisited)
		for _, nextState := range nextStates {
			if len(nextState.floors[0]) == 0 &&
				len(nextState.floors[1]) == 0 &&
				len(nextState.floors[2]) == 0 {
				fmt.Println(nextState.steps)
				return
			}
			queue = append(queue, nextState)
		}
	}
}
