import sequtils
import strscans
import strutils
import sugar
import tables

type
    Rule = object
        destination: string
        testFunction: (Table[char, int]) -> bool

var workflows: Table[string, seq[Rule]]
var parsingWorkflows = true
var count = 0
for line in lines("input.txt"):
    if line.isEmptyOrWhitespace:
        parsingWorkflows = false
    elif parsingWorkflows:
        var splitLine = line.split("{")
        let workflowName = splitLine[0]
        splitLine = splitLine[1][0..^2].split(",")
        var rules: seq[Rule]
        for rule in splitLine:
            if not rule.contains(':'):
                rules.add(Rule(destination: rule, testFunction: (part) => true))
            else:
                let splitRule = rule.split(":")
                let destination = splitRule[1]
                let category = rule[0]
                let test = rule[1]
                let amount = parseInt(splitRule[0][2..^1])
                capture category, amount:
                    let testFunction = if test == '>':
                        proc(part: Table[char, int]): bool =
                            return part[category] > amount
                    else:
                        proc(part: Table[char, int]): bool =
                            return part[category] < amount
                    rules.add(Rule(destination: destination, testFunction: testFunction))
        workflows[workflowName] = rules
    else:
        var xValue, mValue, aValue, sValue: int
        discard scanf(line, "{x=$i,m=$i,a=$i,s=$i}", xValue, mValue, aValue, sValue)
        let part = {'x': xValue, 'm': mValue, 'a': aValue, 's': sValue}.toTable

        var currentWorkflow = workflows["in"]
        var accepted = false
        while true:
            var nextWorkflow: string
            for rule in currentWorkflow:
                if rule.testFunction(part):
                    nextWorkflow = rule.destination
                    break
            if nextWorkflow == "A":
                accepted = true
                break
            elif nextWorkflow == "R":
                break
            else:
                currentWorkflow = workflows[nextWorkflow]
        if accepted:
            count += part.values.toSeq.foldl(a + b)

echo count
