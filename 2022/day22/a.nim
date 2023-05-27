import strutils

var grid: seq[string]
var instructions: string
var readingGrid = true
for line in lines("input"):
    if line.isEmptyOrWhitespace:
        readingGrid = false
    else:
        if readingGrid:
            grid.add(line)
        else:
            instructions = line

var facing = 0
var x = grid[0].find(".")
var y = 0

var current: string
for i in 0 .. instructions.len:
    let c = if i == instructions.len: 'X' else: instructions[i]
    if c == 'R' or c == 'L' or c == 'X':
        var toMove = parseInt(current)
        current = ""

        case facing:
            of 0:
                while toMove > 0:
                    if x == grid[y].len - 1:
                        let firstNonEmpty = grid[y].find({'.', '#'})
                        if grid[y][firstNonEmpty] == '#':
                            break
                        x = firstNonEmpty
                    elif grid[y][x + 1] == '#':
                        break
                    else:
                        x += 1
                    toMove -= 1
            of 1:
                while toMove > 0:
                    if y == grid.len - 1 or grid[y + 1].len <= x or grid[y + 1][x] == ' ':
                        var foundWall = false
                        var i = 0
                        while i < grid.len:
                            if grid[i].len > x and grid[i][x] != ' ':
                                foundWall = grid[i][x] == '#'
                                break
                            i += 1
                        if foundWall:
                            break
                        y = i
                    elif grid[y + 1][x] == '#':
                        break
                    else:
                        y += 1
                    toMove -= 1
            of 2:
                while toMove > 0:
                    if x == 0 or grid[y][x - 1] == ' ':
                        let firstNonEmpty = grid[y].len - 1
                        if grid[y][firstNonEmpty] == '#':
                            break
                        x = firstNonEmpty
                    elif grid[y][x - 1] == '#':
                        break
                    else:
                        x -= 1
                    toMove -= 1
            of 3:
                while toMove > 0:
                    if y == 0 or grid[y - 1].len <= x or grid[y - 1][x] == ' ':
                        var foundWall = false
                        var i = grid.len - 1
                        while i >= 0:
                            if grid[i].len > x and grid[i][x] != ' ':
                                foundWall = grid[i][x] == '#'
                                break
                            i -= 1
                        if foundWall:
                            break
                        y = i
                    elif grid[y - 1][x] == '#':
                        break
                    else:
                        y -= 1
                    toMove -= 1
            else:
                echo "oops!"
        
        if c == 'R':
            facing += 1
            if facing == 4:
                facing = 0
        if c == 'L':
            facing -= 1
            if facing == -1:
                facing = 3
    else:
        current.add(c)

let finalScore = 1000*(y + 1) + 4*(x + 1) + facing
echo finalScore