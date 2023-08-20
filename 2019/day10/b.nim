import algorithm
import sets
import tables

var asteroids: HashSet[(int, int)]

var y = 0
for line in lines("input"):
    for x, c in line:
        if c == '#':
            asteroids.incl((x, y))
    y += 1

var mostSeen = 0
var bestLocation: (int, int)
var bestSlopes: Table[(float, bool, bool), seq[(int, int)]]
for asteroid in asteroids:
    var slopes: Table[(float, bool, bool), seq[(int, int)]]
    for otherAsteroid in asteroids:
        if asteroid == otherAsteroid:
            continue

        var slope = (otherAsteroid[1] - asteroid[1])/(otherAsteroid[0] - asteroid[0])
        if slope == Inf:
            slope = -1000
        let key = (slope, otherAsteroid[0] > asteroid[0], otherAsteroid[1] > asteroid[1])
        if slopes.hasKey(key):
            slopes[key].add(otherAsteroid)
        else:
            slopes[key] = @[otherAsteroid]
    if slopes.len > mostSeen:
        bestLocation = asteroid
        mostSeen = slopes.len
        bestSlopes = slopes

proc slopeSortAscending(x, y: (float, bool, bool)): int =
    cmp(x[0], y[0])

var topRight: seq[(float, bool, bool)]
for key in bestSlopes.keys:
    if key[1] and not key[2]:
        topRight.add(key)

topRight.sort(slopeSortAscending)

var bottomRight: seq[(float, bool, bool)]
for key in bestSlopes.keys:
    if key[1] and key[2]:
        bottomRight.add(key)

bottomRight.sort(slopeSortAscending)

var bottomLeft: seq[(float, bool, bool)]
for key in bestSlopes.keys:
    if not key[1] and key[2]:
        bottomLeft.add(key)

bottomLeft.sort(slopeSortAscending)

var topLeft: seq[(float, bool, bool)]
for key in bestSlopes.keys:
    if not key[1] and not key[2]:
        topLeft.add(key)

topLeft.sort(slopeSortAscending)

let sortedSlopes = topRight & bottomRight & bottomLeft & topLeft
let slope200 = sortedSlopes[199]
echo ((bestSlopes[slope200][0][0]*100) + (bestSlopes[slope200][0][1]))
