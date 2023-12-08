import math
import sequtils
import strscans
import strutils
import sugar
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

let startNodes = collect:
  for k in network.keys:
    if k.endsWith("A"): k

var stepsPerNode: seq[int]

for node in startNodes:
    var currentNode = node
    var steps = 0
    while not currentNode.endsWith("Z"):
        let index = steps mod len(instructions)
        let instruction = instructions[index]
        let options = network[currentNode]
        if instruction == 'R':
            currentNode = options[1]
        else:
            currentNode = options[0]
        steps += 1

    stepsPerNode.add(steps)

echo foldl(stepsPerNode, lcm(a, b))
