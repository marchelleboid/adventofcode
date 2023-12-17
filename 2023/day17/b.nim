import heapqueue
import sets
import strutils
import sugar

type
    State = object
        x: int
        y: int
        pX: int
        pY: int
        straights: int
        heatLoss: int

proc `<`(a, b: State): bool = a.heatLoss < b.heatLoss

var grid = collect:
    for line in lines("input.txt"):
        collect:
            for c in line:
                parseInt($c)

var lowest = high(int)
var seen: HashSet[tuple[x: int, y: int, pX: int, pY: int, straights: int]]

var queue: HeapQueue[State]
queue.push(State(x: 0, y: 0, pX: 0, pY: 0, straights: 0, heatLoss: 0))
seen.incl((x: 0, y: 0, pX: 0, pY: 0, straights: 0))

proc maybeAddNewPath(newX, newY, previousX, previousY, newStraights, currentHeatLoss: int) =
    if newX < 0 or newY < 0 or newX >= len(grid[0]) or newY >= len(grid):
        return
    let newHeatLoss = currentHeatLoss + grid[newY][newX]
    if not seen.contains((x: newX, y: newY, pX: previousX, pY: previousY, straights: newStraights)):
        seen.incl((x: newX, y: newY, pX: previousX, pY: previousY, straights: newStraights))
        queue.push(State(x: newX, y: newY, pX: previousX, pY: previousY, straights: newStraights, heatLoss: newHeatLoss))

while len(queue) > 0:
    let current = queue.pop
    if current.x == len(grid[0]) - 1 and current.y == len(grid) - 1 and current.straights >= 4:
        lowest = min(lowest, current.heatLoss)
        break
    let xDiff = current.x - current.pX
    let yDiff = current.y - current.pY
    if xDiff == 0:
        # Came from up or down
        if current.straights >= 4 or current.straights == 0:
            # Go left
            maybeAddNewPath(current.x - 1, current.y, current.x, current.y, 1, current.heatLoss)
            # Go right
            maybeAddNewPath(current.x + 1, current.y, current.x, current.y, 1, current.heatLoss)
        # Go straight
        if current.straights < 10 and current.straights != 0:
            maybeAddNewPath(current.x, current.y + yDiff, current.x, current.y, current.straights + 1, current.heatLoss)
    elif yDiff == 0:
        # Came from left or right
        if current.straights >= 4 or current.straights == 0:
            # Go up
            maybeAddNewPath(current.x, current.y - 1, current.x, current.y, 1, current.heatLoss)
            # Go down
            maybeAddNewPath(current.x, current.y + 1, current.x, current.y, 1, current.heatLoss)
        # Go straight
        if current.straights < 10 and current.straights != 0:
            maybeAddNewPath(current.x + xDiff, current.y, current.x, current.y, current.straights + 1, current.heatLoss)

echo lowest