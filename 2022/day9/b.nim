import sets
import strutils

var knots: array[10, (int, int)]
for i in 0 .. 9:
    knots[i] = (0, 0)

var visited = initHashSet[(int, int)]()
visited.incl((knots[9][0], knots[9][1]))

for line in lines("input"):
    let splitLine = line.strip.split(" ")
    let direction = splitLine[0]
    var distance = splitLine[1].parseInt
    while distance > 0:
        var (hX, hY) = knots[0]
        if direction == "U":
            hY += 1
        elif direction == "D":
            hY -= 1
        elif direction == "R":
            hX += 1
        else:
            hX -= 1

        knots[0] = (hX, hY)

        distance -= 1

        for x in 1 .. 9:
            let (headX, headY) = knots[x - 1]
            var (tailX, tailY) = knots[x]
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
            knots[x] = (tailX, tailY)

        visited.incl((knots[9][0], knots[9][1]))

echo visited.len