import sequtils
import strutils
import sugar
import tables

var results: Table[(string, seq[int]), int]

proc countArrangements(pattern: string, groups: seq[int]): int =
    if results.contains((pattern, groups)):
        return results[(pattern, groups)]
    let springsLeft = if len(groups) == 0: 0 else: groups.foldl(a + b)
    let possibilities = pattern.count('#') + pattern.count('?')
    if springsLeft == 0 and pattern.count('#') == 0:
        results[(pattern, groups)] = 1
        return 1
    if springsLeft == 0 and pattern.count('#') > 0:
        results[(pattern, groups)] = 0
        return 0
    if springsLeft > possibilities:
        results[(pattern, groups)] = 0
        return 0
    if pattern[0] == '.':
        result = countArrangements(pattern[1 .. ^1], groups)
        results[(pattern, groups)] = result
        return result
    elif pattern[0] == '#':
        var good = true
        if len(pattern) >= groups[0]:
            for i in 0 ..< groups[0]:
                if pattern[i] == '.':
                    good = false
                    break
            if good:
                if len(pattern) == groups[0]:
                    result = countArrangements("", groups[1 .. ^1])
                    results[(pattern, groups)] = result
                    return result
                elif pattern[groups[0]] != '#':
                    result = countArrangements(pattern[groups[0] + 1 .. ^1], groups[1 .. ^1])
                    results[(pattern, groups)] = result
                    return result
        results[(pattern, groups)] = 0
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
                    result = countArrangements("", groups[1 .. ^1])
                    results[(pattern, groups)] = result
                    return result
                elif pattern[groups[0]] != '#':
                    result = countArrangements(pattern[groups[0] + 1 .. ^1], groups[1 .. ^1]) + countArrangements(pattern[1 .. ^1], groups)
                    results[(pattern, groups)] = result
                    return result
                else:
                    result = countArrangements(pattern[1 .. ^1], groups)
                    results[(pattern, groups)] = result
                    return result
            else:
                return countArrangements(pattern[1 .. ^1], groups)
        results[(pattern, groups)] = 0
        return 0

proc countArrangements(line: string): int =
    let pattern = line.split(" ")[0]
    let unfoldedPattern = pattern & "?" & pattern & "?" & pattern & "?" & pattern & "?" & pattern
    let groups = collect:
        for g in line.split(" ")[1].split(","):
            parseInt(g)
    let unfoldedGroups = groups & groups & groups & groups & groups
    return countArrangements(unfoldedPattern, unfoldedGroups)

var count = 0
for line in lines("input.txt"):
    count += countArrangements(line)

echo count
