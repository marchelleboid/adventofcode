import strutils

var xRegister = 1
var cycle = 1
var signalStrengthSum = 0

let importantCycles = @[20, 60, 100, 140, 180, 220]

for line in lines("input"):
    let splitLine = line.strip.split(" ")
    let command = splitLine[0]
    if command == "noop":
        cycle += 1
        if cycle in importantCycles:
            signalStrengthSum += xRegister * cycle
    else:
        let value = splitLine[1].parseInt
        cycle += 1
        if cycle in importantCycles:
            signalStrengthSum += xRegister * cycle
        cycle += 1
        xRegister += value
        if cycle in importantCycles:
            signalStrengthSum += xRegister * cycle

echo signalStrengthSum