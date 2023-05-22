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
        monkeyNumbers[splitLine[0]] = parseInt(splitLine[1])

while not monkeyNumbers.contains("root"):
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

echo monkeyNumbers["root"]
