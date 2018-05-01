package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

type blockedRange struct {
	low  uint64
	high uint64
}

type ByLow []blockedRange

func (l ByLow) Len() int {
	return len(l)
}

func (l ByLow) Swap(i, j int) {
	l[i], l[j] = l[j], l[i]
}

func (l ByLow) Less(i, j int) bool {
	return l[i].low < l[j].low
}

func main() {
	blockedRanges := make([]blockedRange, 0)
	fileHandle, _ := os.Open("../input")
	defer fileHandle.Close()

	fileScanner := bufio.NewScanner(fileHandle)
	for fileScanner.Scan() {
		line := fileScanner.Text()
		splitString := strings.Split(line, "-")
		low, _ := strconv.ParseUint(splitString[0], 10, 64)
		high, _ := strconv.ParseUint(splitString[1], 10, 64)
		blockedRanges = append(blockedRanges, blockedRange{low, high})
	}

	sort.Sort(ByLow(blockedRanges))

	var currentGuess uint64
	var count uint64
	for _, blockedRange := range blockedRanges {
		if currentGuess >= blockedRange.low {
			if currentGuess <= blockedRange.high {
				currentGuess = blockedRange.high + 1
			}
		} else {
			count += blockedRange.low - currentGuess
			currentGuess = blockedRange.high + 1
		}
	}
	count += 4294967295 - currentGuess + 1
	fmt.Println(count)
}
