import sets
import strutils

var headX, headY, tailX, tailY = 0
var visited = initHashSet[(int, int)]()

visited.incl((tailX, taily))

for line in lines("input"):
    let splitLine = line.strip.split(" ")
    let direction = splitLine[0]
    var distance = splitLine[1].parseInt
    while distance > 0:
        if direction == "U":
            headY += 1
        elif direction == "D":
            headY -= 1
        elif direction == "R":
            headX += 1
        else:
            headX -= 1

        distance -= 1

        if headX == tailX:
            let yDifference = headY - tailY
            if yDifference > 1:
                tailY += 1
            elif yDifference < -1:
                tailY -= 1
        elif tailY == headY:
            let xDifference = headX - tailX
            if xDifference > 1:
                tailX += 1
            elif xDifference < -1:
                tailX -= 1
        else:
            let yDifference = headY - tailY
            let xDifference = headX - tailX
            if abs(yDifference) > 1 or abs(xDifference) > 1:
                if yDifference >= 1:
                    tailY += 1
                elif yDifference <= -1:
                    tailY -= 1

                if xDifference >= 1:
                    tailX += 1
                elif xDifference <= -1:
                    tailX -= 1

        visited.incl((tailX, tailY))

echo visited.len