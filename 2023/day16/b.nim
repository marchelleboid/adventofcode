import deques
import hashes
import sets
import sugar

type
    Direction = enum
        UP, DOWN, RIGHT, LEFT

type
    Beam = object
        x: int
        y: int
        direction: Direction

proc hash(b: Beam): Hash =
    var h: Hash = 0
    h = h !& hash(b.x)
    h = h !& hash(b.y)
    h = h !& hash(b.direction)
    return !$h

var grid = collect:
    for line in lines("input.txt"):
        line

let maxY = len(grid) - 1
let maxX = len(grid[0]) - 1

proc getEnergizedBeams(startX, startY: int, startDirection: Direction): int =
    var seen: HashSet[Beam]
    var stack: Deque[Beam]
    stack.addLast(Beam(x: startX, y: startY, direction: startDirection))
    while len(stack) > 0:
        let current = stack.popFirst
        if seen.contains(current):
            continue
        seen.incl(current)
        let spot = grid[current.y][current.x]
        if spot == '.':
            if current.direction == RIGHT and current.x < maxX:
                stack.addLast(Beam(x: current.x + 1, y: current.y, direction: RIGHT))
            elif current.direction == LEFT and current.x > 0:
                stack.addLast(Beam(x: current.x - 1, y: current.y, direction: LEFT))
            elif current.direction == DOWN and current.y < maxY:
                stack.addLast(Beam(x: current.x, y: current.y + 1, direction: DOWN))
            elif current.direction == UP and current.y > 0:
                stack.addLast(Beam(x: current.x, y: current.y - 1, direction: UP))
        elif spot == '-':
            if current.x < maxX and @[RIGHT, DOWN, UP].contains(current.direction):
                stack.addLast(Beam(x: current.x + 1, y: current.y, direction: RIGHT))
            if current.x > 0 and @[LEFT, DOWN, UP].contains(current.direction):
                stack.addLast(Beam(x: current.x - 1, y: current.y, direction: LEFT))
        elif spot == '|':
            if current.y > 0 and @[UP, LEFT, RIGHT].contains(current.direction):
                stack.addLast(Beam(x: current.x, y: current.y - 1, direction: UP))
            if current.y < maxY and @[DOWN, LEFT, RIGHT].contains(current.direction):
                stack.addLast(Beam(x: current.x, y: current.y + 1, direction: DOWN))
        elif spot == '\\':
            if current.direction == RIGHT and current.y < maxY:
                stack.addLast(Beam(x: current.x, y: current.y + 1, direction: DOWN))
            elif current.direction == LEFT and current.y > 0:
                stack.addLast(Beam(x: current.x, y: current.y - 1, direction: UP))
            elif current.direction == DOWN and current.x < maxX:
                stack.addLast(Beam(x: current.x + 1, y: current.y, direction: RIGHT))
            elif current.direction == UP and current.x > 0:
                stack.addLast(Beam(x: current.x - 1, y: current.y, direction: LEFT))
        elif spot == '/':
            if current.direction == LEFT and current.y < maxY:
                stack.addLast(Beam(x: current.x, y: current.y + 1, direction: DOWN))
            elif current.direction == RIGHT and current.y > 0:
                stack.addLast(Beam(x: current.x, y: current.y - 1, direction: UP))
            elif current.direction == UP and current.x < maxX:
                stack.addLast(Beam(x: current.x + 1, y: current.y, direction: RIGHT))
            elif current.direction == DOWN and current.x > 0:
                stack.addLast(Beam(x: current.x - 1, y: current.y, direction: LEFT))

    var onlyLocations = collect:
        for b in seen:
            (b.x, b.y)

    return len(onlyLocations.toHashSet)

var maxEnergized = 0
for x in 0 .. maxX:
    maxEnergized = max(maxEnergized, getEnergizedBeams(x, 0, DOWN))
    maxEnergized = max(maxEnergized, getEnergizedBeams(x, maxY, UP))

for y in 0 .. maxY:
    maxEnergized = max(maxEnergized, getEnergizedBeams(0, y, RIGHT))
    maxEnergized = max(maxEnergized, getEnergizedBeams(maxX, y, LEFT))

echo maxEnergized
