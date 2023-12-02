import strutils

let maxRed = 12
let maxGreen = 13
let maxBlue = 14

var count = 0
for line in lines("input"):
    let firstSplit = line.split(": ")
    let gameId = parseInt(firstSplit[0].split(" ")[1])
    let setSplit = firstSplit[1].split(";")

    var possible = true
    for st in setSplit:
        let cubeSplit = st.split(",")
        for cube in cubeSplit:
            var amount = parseInt(cube.strip.split(" ")[0])
            var color = cube.strip.split(" ")[1]

            if color == "red" and amount > maxRed:
                possible = false
                break
            elif color == "green" and amount > maxGreen:
                possible = false
                break
            elif color == "blue" and amount > maxBlue:
                possible = false
                break
        if not possible:
            break
    
    if possible:
        count += gameId

echo count