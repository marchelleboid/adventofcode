import deques
import strutils
import tables

type
    Rule = object
        destination: string
        category: char
        test: char
        amount: int

var workflows: Table[string, seq[Rule]]
for line in lines("input.txt"):
    if line.isEmptyOrWhitespace:
        break
    else:
        var splitLine = line.split("{")
        let workflowName = splitLine[0]
        splitLine = splitLine[1][0..^2].split(",")
        var rules: seq[Rule]
        for rule in splitLine:
            if not rule.contains(':'):
                rules.add(Rule(destination: rule))
            else:
                let splitRule = rule.split(":")
                let destination = splitRule[1]
                let category = rule[0]
                let test = rule[1]
                let amount = parseInt(splitRule[0][2..^1])
                rules.add(Rule(destination: destination, category: category, test: test, amount: amount))
        workflows[workflowName] = rules

func statePossibilities(state: tuple[minX, maxX, minM, maxM, minA, maxA, minS, maxS: int]): int =
    return (state.maxX - state.minX + 1)*(state.maxM - state.minM + 1)*(state.maxA - state.minA + 1)*(state.maxS - state.minS + 1)

var count = 0
var stack: Deque[tuple[workflow: string, state: tuple[minX, maxX, minM, maxM, minA, maxA, minS, maxS: int]]]
stack.addFirst((workflow: "in", state: (minX: 1, maxX: 4000, minM: 1, maxM: 4000, minA: 1, maxA: 4000, minS: 1, maxS: 4000)))
while len(stack) > 0:
    let node = stack.popFirst
    let rules = workflows[node.workflow]
    var updatedState = node.state
    for i in 0 ..< len(rules) - 1:
        let rule = rules[i]
        var newState = updatedState
        if rule.category == 'x':
            if rule.test == '<':
                newState.maxX = rule.amount - 1
                updatedState.minX = rule.amount
            else:
                newState.minX = rule.amount + 1
                updatedState.maxX = rule.amount
        elif rule.category == 'm':
            if rule.test == '<':
                newState.maxM = rule.amount - 1
                updatedState.minM = rule.amount
            else:
                newState.minM = rule.amount + 1
                updatedState.maxM = rule.amount
        elif rule.category == 'a':
            if rule.test == '<':
                newState.maxA = rule.amount - 1
                updatedState.minA = rule.amount
            else:
                newState.minA = rule.amount + 1
                updatedState.maxA = rule.amount
        else:
            if rule.test == '<':
                newState.maxS = rule.amount - 1
                updatedState.minS = rule.amount
            else:
                newState.minS = rule.amount + 1
                updatedState.maxS = rule.amount
        if rule.destination == "A":
            count += statePossibilities(newState)
        elif rule.destination != "R":
            stack.addLast((workflow: rule.destination, state: newState))

    let lastRule = rules[^1]
    if lastRule.destination == "A":
        count += statePossibilities(updatedState)
    elif lastRule.destination != "R":
        stack.addLast((workflow: lastRule.destination, state: updatedState))

echo count
