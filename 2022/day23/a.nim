import seqUtils
import sets

type
    Direction = enum
        North, South, West, East

func proposalOrder(first: int) : array[4, Direction] =
    if first == 0:
        return [North, South, West, East]
    elif first == 1:
        return [South, West, East, North]
    elif first == 2:
        return [West, East, North, South]
    else:
        return [East, North, South, West]

var occupied = initHashSet[(int, int)]()
var row = 0
for line in lines("input"):
    for i, c in line:
        if c == '#':
            occupied.incl((i, row))
    inc row

var elves = occupied.toSeq
var round = 0
while round < 10:
    var elfProposals = newSeq[(int, int)](elves.len)
    var proposals = initHashSet[(int, int)]()
    var proposalConflicts = initHashSet[(int, int)]()

    # Proposals
    let order = proposalOrder(round mod 4)
    for i, elf in elves:
        let elfX = elf[0]
        let elfY = elf[1]

        var canMoveNorth, canMoveSouth, canMoveWest, canMoveEast = false
        if not (occupied.contains((elfX, elfY - 1)) or occupied.contains((elfX - 1, elfY - 1)) or occupied.contains((elfX + 1, elfY - 1))):
            canMoveNorth = true
        if not (occupied.contains((elfX, elfY + 1)) or occupied.contains((elfX - 1, elfY + 1)) or occupied.contains((elfX + 1, elfY + 1))):
            canMoveSouth = true
        if not (occupied.contains((elfX - 1, elfY)) or occupied.contains((elfX - 1, elfY + 1)) or occupied.contains((elfX - 1, elfY - 1))):
            canMoveWest = true
        if not (occupied.contains((elfX + 1, elfY)) or occupied.contains((elfX + 1, elfY + 1)) or occupied.contains((elfX + 1, elfY - 1))):
            canMoveEast = true

        var standStill = canMoveNorth and canMoveSouth and canMoveWest and canMoveEast or (not canMoveNorth and not canMoveSouth and not canMoveWest and not canMoveEast)
        if standStill:
            elfProposals[i] = elf
        if not standStill:
            var proposal: (int, int)
            for o in order:
                if o == North:
                    if canMoveNorth:
                        proposal = (elfX, elfY - 1)
                        standStill = false
                        break
                elif o == South:
                    if canMoveSouth:
                        proposal = (elfX, elfY + 1)
                        standStill = false
                        break
                elif o == West:
                    if canMoveWest:
                        proposal = (elfX - 1, elfY)
                        standStill = false
                        break
                else:
                    if canMoveEast:
                        proposal = (elfX + 1, elfY)
                        standStill = false
                        break

            elfProposals[i] = proposal
            if proposals.contains(proposal):
                proposalConflicts.incl(proposal)
            else:
                proposals.incl(proposal)


    # Moves
    occupied.clear
    for i, elfProposal in elfProposals:
        if not proposalConflicts.contains(elfProposal):
            elves[i] = elfProposal
            occupied.incl(elfProposal)
        else:
            occupied.incl(elves[i])

    inc round

var minX, minY = high(int)
var maxX, maxY = low(int)
for elf in elves:
    minX = min(elf[0], minX)
    minY = min(elf[1], minY)
    maxX = max(elf[0], maxX)
    maxY = max(elf[1], maxY)

var emptyCount = 0
for y in minY .. maxY:
    for x in minX .. maxX:
        if not occupied.contains((x, y)):
            inc emptyCount

echo emptyCount