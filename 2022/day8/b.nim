import sequtils
import sets
import strutils

var grid = newSeq[seq[int]](0)

for line in lines("input"):
    grid.add(map(line.strip, proc (c: char): int = ord(c) - ord('0')))

var visibles = initHashSet[(int, int)]()

# From left
for i in 1 .. grid.len - 2:
    let line = grid[i]
    var currentHigh = line[0]
    for j in 1 .. line.len - 2:
        if line[j] > currentHigh:
            visibles.incl((i, j))
            currentHigh = line[j]

# From right
for i in 1 .. grid.len - 2:
    let line = grid[i]
    var currentHigh = line[^1]
    for j in countdown(line.len - 2, 1):
        if line[j] > currentHigh:
            visibles.incl((i, j))
            currentHigh = line[j]

# From top
for j in 1 .. grid[0].len - 2:
    var currentHigh = grid[0][j]
    for i in 1 .. grid.len - 2:
        if grid[i][j] > currentHigh:
            visibles.incl((i, j))
            currentHigh = grid[i][j]

# From bottom
for j in 1 .. grid[0].len - 2:
    var currentHigh = grid[^1][j]
    for i in countdown(grid.len - 2, 1):
        if grid[i][j] > currentHigh:
            visibles.incl((i, j))
            currentHigh = grid[i][j]

proc calculateScenicScore(i: int, j: int): int =
    var height = grid[i][j]
    var leftView = 0
    for x in countdown(j - 1, 0):
        leftView += 1
        if grid[i][x] >= height:
            break
    
    var rightView = 0
    for x in j + 1 .. grid[0].len - 1:
        rightView += 1
        if grid[i][x] >= height:
            break

    var upView = 0
    for y in countdown(i - 1, 0):
        upView += 1
        if grid[y][j] >= height:
            break

    var downView = 0
    for y in i + 1 .. grid.len - 1:
        downView += 1
        if grid[y][j] >= height:
            break
    
    return leftView * rightView * upView * downView

var highScore = 0
for visible in visibles:
    highScore = max(calculateScenicScore(visible[0], visible[1]), highScore)

echo highScore