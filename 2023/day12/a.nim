import sequtils
import strutils
import sugar

proc countArrangements(pattern: string, groups: seq[int]): int =
    let springsLeft = if len(groups) == 0: 0 else: groups.foldl(a + b)
    let possibilities = pattern.count('#') + pattern.count('?')
    if springsLeft == 0 and pattern.count('#') == 0:
        return 1
    if springsLeft == 0 and pattern.count('#') > 0:
        return 0
    if springsLeft > possibilities:
        return 0
    if pattern[0] == '.':
        return countArrangements(pattern[1 .. ^1], groups)
    elif pattern[0] == '#':
        var good = true
        if len(pattern) >= groups[0]:
            for i in 0 ..< groups[0]:
                if pattern[i] == '.':
                    good = false
                    break
            if good:
                if len(pattern) == groups[0]:
                    return countArrangements("", groups[1 .. ^1])
                elif pattern[groups[0]] != '#':
                    return countArrangements(pattern[groups[0] + 1 .. ^1], groups[1 .. ^1])
        return 0
    else:
        var good = true
        if len(pattern) >= groups[0]:
            for i in 0 ..< groups[0]:
                if pattern[i] == '.':
                    good = false
                    break
            if good:
                if len(pattern) == groups[0]:
                    return countArrangements("", groups[1 .. ^1])
                elif pattern[groups[0]] != '#':
                    return countArrangements(pattern[groups[0] + 1 .. ^1], groups[1 .. ^1]) + countArrangements(pattern[1 .. ^1], groups)
                else:
                    return countArrangements(pattern[1 .. ^1], groups)
            else:
                return countArrangements(pattern[1 .. ^1], groups)
        return 0

proc countArrangements(line: string): int =
    let pattern = line.split(" ")[0]
    let groups = collect:
        for g in line.split(" ")[1].split(","):
            parseInt(g)
    return countArrangements(pattern, groups)

var count = 0
for line in lines("input.txt"):
    count += countArrangements(line)

echo count
