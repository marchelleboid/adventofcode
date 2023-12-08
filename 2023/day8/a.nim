import strscans
import strutils
import tables

var instructions = ""
var network: Table[string, (string, string)]
for line in lines("input.txt"):
    if instructions.isEmptyOrWhitespace:
        instructions = line
    elif not line.isEmptyOrWhitespace:
        var nodeName, leftNode, rightNode: string
        discard line.scanf("$w = ($w, $w)", nodeName, leftNode, rightNode)
        network[nodeName] = (leftNode, rightNode)

var currentNode = "AAA"
var steps = 0

while currentNode != "ZZZ":
    let index = steps mod len(instructions)
    let instruction = instructions[index]
    let options = network[currentNode]
    if instruction == 'R':
        currentNode = options[1]
    else:
        currentNode = options[0]
    steps += 1

echo steps