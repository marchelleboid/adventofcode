module Day17b

// target area: x=135..155, y=-102..-78

let rec doesSpeedWork xSpeed ySpeed xPos yPos = 
    if xPos >= 135 && xPos <= 155 && yPos >= -102 && yPos <= -78
    then true
    elif xPos > 155 || yPos < -102
    then false
    else doesSpeedWork (max (xSpeed - 1) 0) (ySpeed - 1) (xPos + xSpeed) (yPos + ySpeed)

let solver =
    let mutable count = 0
    for y in -102..101 do
        for x in 16..155 do
            if doesSpeedWork x y 0 0
            then count <- count + 1
    printfn "%d" count