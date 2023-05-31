import deques
import sets

var initialState: seq[seq[seq[char]]]
for line in lines("input"):
    var row: seq[seq[char]]
    for c in line:
        if c != '.':
            row.add(@[c])
        else:
            row.add(@[])
    initialState.add(row)

let loopY = initialState.len - 2
let loopX = initialState[0].len - 2

proc getNextState(previousState: seq[seq[seq[char]]]): seq[seq[seq[char]]] =
    var nextState = newSeq[seq[seq[char]]](previousState.len)
    for i in 0 ..< nextState.len:
        nextState[i] = newSeq[seq[char]](previousState[0].len)

    for y, row in previousState:
        for x, blizzards in row:
            if blizzards.len == 0:
                continue
            if blizzards == @['#']:
                nextState[y][x] = @['#']
            else:
                for blizzard in blizzards:
                    case blizzard:
                        of '<':
                            if x == 1:
                                nextState[y][loopX].add(blizzard)
                            else:
                                nextState[y][x - 1].add(blizzard)
                        of '>':
                            if x == loopX:
                                nextState[y][1].add(blizzard)
                            else:
                                nextState[y][x + 1].add(blizzard)
                        of '^':
                            if y == 1:
                                nextState[loopY][x].add(blizzard)
                            else:
                                nextState[y - 1][x].add(blizzard)
                        else:
                            if y == loopY:
                                nextState[1][x].add(blizzard)
                            else:
                                nextState[y + 1][x].add(blizzard)

    return nextState

var states: seq[seq[seq[seq[char]]]]
states.add(initialState)

proc findPath(targetX, targetY: int, initialMove: (int, int, int)): int =
    var moves = [initialMove].toDeque
    var seen = toHashSet([initialMove])
    while moves.len > 0:
        let move = moves.popFirst

        let nextMinute = move[2] + 1
        if states.len == nextMinute:
            states.add(getNextState(states[move[2]]))
        let nextState = states[nextMinute]

        # Move down
        if move[1] < initialState.len - 1 and nextState[move[1] + 1][move[0]].len == 0:
            if move[0] == targetX and move[1] + 1 == targetY:
                return nextMinute
            let newMove = (move[0], move[1] + 1, nextMinute)
            if newMove notin seen:
                moves.addLast(newMove)
                seen.incl(newMove)

        # Move right
        if nextState[move[1]][move[0] + 1].len == 0:
            let newMove = (move[0] + 1, move[1], nextMinute)
            if newMove notin seen:
                moves.addLast(newMove)
                seen.incl(newMove)

        # Move up
        if move[1] > 0 and nextState[move[1] - 1][move[0]].len == 0:
            if move[0] == targetX and move[1] - 1 == targetY:
                return nextMinute
            let newMove = (move[0], move[1] - 1, nextMinute)
            if newMove notin seen:
                moves.addLast(newMove)
                seen.incl(newMove)

        # Move left
        if nextState[move[1]][move[0] - 1].len == 0:
            let newMove = (move[0] - 1, move[1], nextMinute)
            if newMove notin seen:
                moves.addLast(newMove)
                seen.incl(newMove)

        # Stay
        if nextState[move[1]][move[0]].len == 0:
            let newMove = (move[0], move[1], nextMinute)
            if newMove notin seen:
                moves.addLast(newMove)
                seen.incl(newMove)

let firstX = initialState[0].len - 2
let firstY = initialState.len - 1
let firstMinutes = findPath(firstX, firstY, (1, 0, 0))

let secondX = 1
let secondY = 0
let secondMinutes = findPath(secondX, secondY, (firstX, firstY, firstMinutes))

let thirdMinutes = findPath(firstX, firstY, (1, 0, secondMinutes))

echo thirdMinutes