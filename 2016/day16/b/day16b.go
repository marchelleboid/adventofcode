package main

import (
	"fmt"
)

func reverseAndFlip(a string) string {
	b := []rune(a)
	for i := 0; i < len(a); i++ {
		if a[i] == '0' {
			b[len(a)-i-1] = '1'
		} else {
			b[len(a)-i-1] = '0'
		}
	}
	return string(b)
}

func calculateChecksum(data string) string {
	checksum := make([]rune, len(data)/2)
	for i := 0; i < len(data); i = i + 2 {
		pair := data[i : i+2]
		if pair == "00" || pair == "11" {
			checksum[i/2] = '1'
		} else {
			checksum[i/2] = '0'
		}
	}
	if len(checksum)%2 != 0 {
		return string(checksum)
	}
	return calculateChecksum(string(checksum))
}

func main() {
	data := "11101000110010100"
	desiredLength := 35651584

	for len(data) < desiredLength {
		data = data + "0" + reverseAndFlip(data)
	}
	data = data[:desiredLength]
	fmt.Println(calculateChecksum(data))
}
