import strutils

let lines = readLines("input.txt", 2)

let time = lines[0].split(": ")[1].splitWhitespace.join.parseInt
let distance = lines[1].split(": ")[1].splitWhitespace.join.parseInt

var count = 0

for powerUp in 1 .. time - 1:
    let timeLeft = time - powerUp
    let distanceTravelled = timeLeft * powerUp
    if distanceTravelled > distance:
        count += 1

echo count
