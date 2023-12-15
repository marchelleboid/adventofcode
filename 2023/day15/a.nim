import strutils

let line = readLines("input.txt", 1)

var count = 0
for step in line[0].split(","):
    var stepCount = 0
    for c in step:
        stepCount += ord(c)
        stepCount *= 17
        stepCount = stepCount mod 256
    count += stepCount

echo count