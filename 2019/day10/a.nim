import sets

var asteroids: HashSet[(int, int)]

var y = 0
for line in lines("input"):
    for x, c in line:
        if c == '#':
            asteroids.incl((x, y))
    y += 1

var mostSeen = 0
for asteroid in asteroids:
    var slopes: HashSet[(float, bool, bool)]
    for otherAsteroid in asteroids:
        if asteroid == otherAsteroid:
            continue

        let slope = (otherAsteroid[1] - asteroid[1])/(otherAsteroid[0] - asteroid[0])
        slopes.incl((slope, otherAsteroid[0] > asteroid[0], otherAsteroid[1] > asteroid[1]))
    mostSeen = max(mostSeen, slopes.len)

echo mostSeen
