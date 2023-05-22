import strscans
import strutils
import tables

var monkeyNumbers: Table[string, int]
var monkeyOperations: Table[string, (string, string, char)]

for line in lines("input"):
    let splitLine = line.split(": ")
    if splitLine[1].contains(" "):
        var monkey1, monkey2: string
        var op: char
        discard splitLine[1].scanf("$w $c $w", monkey1, op, monkey2)
        monkeyOperations[splitLine[0]] = (monkey1, monkey2, op)
    else:
        if splitLine[0] != "humn":
            monkeyNumbers[splitLine[0]] = parseInt(splitLine[1])

var keepGoing = true
while keepGoing:
    keepGoing = false
    var monkeysToRemove: seq[string]
    for k, v in monkeyOperations.pairs:
        if monkeyNumbers.contains(v[0]) and monkeyNumbers.contains(v[1]):
            var number = case v[2]:
                of '+':
                    monkeyNumbers[v[0]] + monkeyNumbers[v[1]]
                of '-':
                    monkeyNumbers[v[0]] - monkeyNumbers[v[1]]
                of '*':
                    monkeyNumbers[v[0]] * monkeyNumbers[v[1]]
                of '/':
                    int(monkeyNumbers[v[0]] / monkeyNumbers[v[1]])
                else:
                    -1
            monkeyNumbers[k] = number
            monkeysToRemove.add(k)
    for m in monkeysToRemove:
        monkeyOperations.del(m)
        keepGoing = true

var currentMonkey = "root"
var target: int
while true:
    let operation = monkeyOperations[currentMonkey]
    let monkey1 = operation[0]
    let monkey2 = operation[1]
    let op = if currentMonkey == "root": '=' else: operation[2]

    var value: int
    var nextMonkey: string
    var unknownFirst: bool
    if monkeyNumbers.contains(monkey1):
        value = monkeyNumbers[monkey1]
        nextMonkey = monkey2
        unknownFirst = false
    else:
        value = monkeyNumbers[monkey2]
        nextMonkey = monkey1
        unknownFirst = true
    
    case op:
        of '=':
            target = value
        of '+':
            target = target - value
        of '-':
            if unknownFirst:
                target = target + value
            else:
                target = value - target
        of '*':
            target = int(target / value)
        of '/':
            if unknownFirst:
                target = target * value
            else:
                target = int(value / target)
        else:
            echo "uh oh"

    if nextMonkey == "humn":
        break
    currentMonkey = nextMonkey

echo target
