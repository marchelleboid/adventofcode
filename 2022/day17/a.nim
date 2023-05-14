import sequtils
import sets

let jet = readFile("input")

var shapeIndex = 0
var jetIndex = 0

var rocks = initHashSet[(int, int)]()
rocks.incl((0, 0))
rocks.incl((1, 0))
rocks.incl((2, 0))
rocks.incl((3, 0))
rocks.incl((4, 0))
rocks.incl((5, 0))
rocks.incl((6, 0))

var rockBottom = 4
var rockLeft = 2
var maxHeight = 0

func shapePositions(index, left, bottom: int): seq[(int, int)] =
    return case index:
        of 0:
            @[(left, bottom),
              (left + 1, bottom),
              (left + 2, bottom),
              (left + 3, bottom)]
        of 1:
            @[(left, bottom + 1),
              (left + 1, bottom + 1),
              (left + 2, bottom + 1),
              (left + 1, bottom),
              (left + 1, bottom + 2)]
        of 2:
            @[(left, bottom),
              (left + 1, bottom),
              (left + 2, bottom),
              (left + 2, bottom + 1),
              (left + 2, bottom + 2)]
        of 3:
            @[(left, bottom),
              (left, bottom + 1),
              (left, bottom + 2),
              (left, bottom + 3)]
        of 4:
            @[(left, bottom),
              (left, bottom + 1),
              (left + 1, bottom),
              (left + 1, bottom + 1)]
        else:
            @[]

proc pushRight(index, left, bottom: int): (int, int) =
    var positions = shapePositions(index, left, bottom)
    positions = map(positions, proc(x: (int, int)): (int, int) = (x[0] + 1, x[1]))
    let canPush = case index:
        of 0:
            left != 3 and
            not rocks.contains(positions[3])
        of 1:
            left != 4 and
            not rocks.contains(positions[2]) and
            not rocks.contains(positions[3]) and
            not rocks.contains(positions[4])
        of 2:
            left != 4 and
            not rocks.contains(positions[2]) and
            not rocks.contains(positions[3]) and
            not rocks.contains(positions[4])
        of 3:
            left != 6 and
            all(positions, proc(x: (int, int)): bool = not rocks.contains(x))
        of 4:
            left != 5 and
            not rocks.contains(positions[2]) and
            not rocks.contains(positions[3])
        else:
            false
    if canPush:
        return (left + 1, bottom)
    else:
        return (left, bottom)

proc pushLeft(index, left, bottom: int): (int, int) =
    if left == 0:
        return (left, bottom)
    var positions = shapePositions(index, left, bottom)
    positions = map(positions, proc(x: (int, int)): (int, int) = (x[0] - 1, x[1]))
    let canPush = case index:
        of 0:
            not rocks.contains(positions[0])
        of 1:
            not rocks.contains(positions[0]) and
            not rocks.contains(positions[3]) and
            not rocks.contains(positions[4])
        of 2:
            not rocks.contains(positions[0]) and
            not rocks.contains(positions[3]) and
            not rocks.contains(positions[4])
        of 3:
            all(positions, proc(x: (int, int)): bool = not rocks.contains(x))
        of 4:
            not rocks.contains(positions[0]) and
            not rocks.contains(positions[1])
        else:
            false
    if canPush:
        return (left - 1, bottom)
    else:
        return (left, bottom)

proc dropDown(index, left, bottom: int): (int, int) =
    var positions = shapePositions(index, left, bottom)
    positions = map(positions, proc(x: (int, int)): (int, int) = (x[0], x[1] - 1))
    let canDrop = case index:
        of 0:
            all(positions, proc(x: (int, int)): bool = not rocks.contains(x))
        of 1:
            not rocks.contains(positions[0]) and
            not rocks.contains(positions[2]) and
            not rocks.contains(positions[3])
        of 2:
            not rocks.contains(positions[0]) and
            not rocks.contains(positions[1]) and
            not rocks.contains(positions[2])
        of 3:
            not rocks.contains(positions[0])
        of 4:
            not rocks.contains(positions[0]) and
            not rocks.contains(positions[2])
        else:
            false
    if canDrop:
        return (left, bottom - 1)
    else:
        return (left, bottom)

for _ in 1 .. 2022:
    var stopped = false
    while not stopped:
        let push = jet[jetIndex]

        if push == '>':
            (rockLeft, rockBottom) = pushRight(shapeIndex, rockLeft, rockBottom)
        else:
            (rockLeft, rockBottom) = pushLeft(shapeIndex, rockLeft, rockBottom)

        var (newLeft, newBottom) = dropDown(shapeIndex, rockLeft, rockBottom)
        if newLeft == rockLeft and newBottom == rockBottom:
            stopped = true
            for p in shapePositions(shapeIndex, rockLeft, rockBottom):
                rocks.incl(p)
                if p[1] > maxHeight:
                    maxHeight = p[1]
        else:
            rockBottom = newBottom

        jetIndex += 1
        if jetIndex == len(jet):
            jetIndex = 0

    shapeIndex += 1
    if shapeIndex == 5:
        shapeIndex = 0
    
    rockLeft = 2
    rockBottom = maxHeight + 4

echo maxHeight