import sequtils
import strutils

let lines = readLines("input.txt", 2)

let times = lines[0].split(": ")[1].splitWhitespace.map(proc(x: string): int = parseInt(x))
let distances = lines[1].split(": ")[1].splitWhitespace.map(proc(x: string): int = parseInt(x))

var totalCount = 1
for i in 0 .. len(times) - 1:
    let time = times[i]
    let distance = distances[i]

    var count = 0
    for powerUp in 1 .. time - 1:
        let timeLeft = time - powerUp
        let distanceTravelled = timeLeft * powerUp
        if distanceTravelled > distance:
            count += 1
   
    totalCount *= count

echo totalCount
