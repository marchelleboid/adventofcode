import math
import strscans

type
  Moon = object
    posX, posY, posZ, velX, velY, velZ : int

var moons: array[0..3, Moon]

var count = 0
for line in lines("input"):
    var posX, posY, posZ: int
    discard line.scanf("<x=$i, y=$i, z=$i>", posX, posY, posZ)
    moons[count] = Moon(posX: posX, posY: posY, posZ: posZ, velX: 0, velY: 0, velZ: 0)
    count += 1

var done = false
var step = 0
var xCycle, yCycle, zCycle = 0

while not done:

    var newMoons: array[0..3, Moon]
    for i in 0 .. 3:
        var velXChange, velYChange, velZChange = 0
        let currentMoon = moons[i]
        for j in 0 .. 3:
            if i == j:
                continue
            
            let otherMoon = moons[j]
            if currentMoon.posX > otherMoon.posX:
                velXChange -= 1
            elif currentMoon.posX < otherMoon.posX:
                velXChange += 1
            
            if currentMoon.posY > otherMoon.posY:
                velYChange -= 1
            elif currentMoon.posY < otherMoon.posY:
                velYChange += 1
            
            if currentMoon.posZ > otherMoon.posZ:
                velZChange -= 1
            elif currentMoon.posZ < otherMoon.posZ:
                velZChange += 1
        
        let newVelX = currentMoon.velX + velXChange
        let newVelY = currentMoon.velY + velYChange
        let newVelZ = currentMoon.velZ + velZChange

        let newPosX = currentMoon.posX + newVelX
        let newPosY = currentMoon.posY + newVelY
        let newPosZ = currentMoon.posZ + newVelZ

        newMoons[i] = Moon(posX: newPosX, posY: newPosY, posZ: newPosZ, velX: newVelX, velY: newVelY, velZ: newVelZ)
    
    moons = newMoons
    step += 1

    if xCycle == 0:
        if moons[0].velX == 0 and 
            moons[1].velX == 0 and
            moons[2].velX == 0 and
            moons[3].velX == 0:
            xCycle = step
    
    if yCycle == 0:
        if moons[0].velY == 0 and 
            moons[1].velY == 0 and
            moons[2].velY == 0 and
            moons[3].velY == 0:
            yCycle = step

    if zCycle == 0:
        if moons[0].velZ == 0 and 
            moons[1].velZ == 0 and
            moons[2].velZ == 0 and
            moons[3].velZ == 0:
            zCycle = step
    
    if xCycle != 0 and yCycle != 0 and zCycle != 0:
        done = true

var totalCycle = lcm(lcm(xCycle, yCycle), zCycle) * 2

echo totalCycle
