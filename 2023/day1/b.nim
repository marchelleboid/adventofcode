import algorithm
import sequtils
import strutils

func findFirstOf(line, sub: string): int =
    let index = line.find(sub)
    if index == -1:
        return 9999
    else:
        return index

var count = 0
for line in lines("input"):
    var firstDigit: char
    var firstDigitIndex = 9999
    var lastDigit: char
    var lastDigitIndex = -1
    for i, c in line:
        if c.isDigit:
            firstDigit = c
            firstDigitIndex = i
            break
    for i, c in line.reversed:
        if c.isDigit:
            lastDigit = c
            lastDigitIndex = len(line) - i - 1
            break
    
    let firstOne = findFirstOf(line, "one")
    let firstTwo = findFirstOf(line, "two")
    let firstThree = findFirstOf(line, "three")
    let firstFour = findFirstOf(line, "four")
    let firstFive = findFirstOf(line, "five")
    let firstSix = findFirstOf(line, "six")
    let firstSeven = findFirstOf(line, "seven")
    let firstEight = findFirstOf(line, "eight")
    let firstNine = findFirstOf(line, "nine")

    let firsts = @[firstOne, firstTwo, firstThree, firstFour, firstFive, firstSix, firstSeven, firstEight, firstNine]
    let minIndex = firsts.minIndex
    var first: string
    if firsts[minIndex] < firstDigitIndex:
        first = $(minIndex + 1)
    else:
        first = $firstDigit

    let lastOne = line.rfind("one")
    let lastTwo = line.rfind("two")
    let lastThree = line.rfind("three")
    let lastFour = line.rfind("four")
    let lastFive = line.rfind("five")
    let lastSix = line.rfind("six")
    let lastSeven = line.rfind("seven")
    let lastEight = line.rfind("eight")
    let lastNine = line.rfind("nine")

    let lasts = @[lastOne, lastTwo, lastThree, lastFour, lastFive, lastSix, lastSeven, lastEight, lastNine]
    let maxIndex = lasts.maxIndex
    var last: string
    if lasts[maxIndex] > lastDigitIndex:
        last = $(maxIndex + 1)
    else:
        last = $lastDigit

    count += parseInt(first & last)

echo count