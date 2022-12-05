import strutils

var stacks: array[1..9, seq[string]]
stacks[1] = @["S", "C", "V", "N"]
stacks[2] = @["Z", "M", "J", "H", "N", "S"]
stacks[3] = @["M", "C", "T", "G", "J", "N", "D"]
stacks[4] = @["T", "D", "F", "J", "W", "R", "M"]
stacks[5] = @["P", "F", "H"]
stacks[6] = @["C", "T", "Z", "H", "J"]
stacks[7] = @["D", "P", "R", "Q", "F", "S", "L", "Z"]
stacks[8] = @["C", "S", "L", "H", "D", "F", "P", "W"]
stacks[9] = @["D", "S", "M", "P", "F", "N", "G", "Z"]

for line in lines("input"):
    let splitLine = line.strip.split(" ")
    if splitLine[0] != "move":
        continue

    let toMove = splitLine[1].parseInt
    var tmpStack = newSeqOfCap[string](toMove)
    for _ in 0 ..< toMove:
        tmpStack.add(stacks[splitLine[3].parseInt].pop)

    for _ in 0 ..< toMove:  
        stacks[splitLine[5].parseInt].add(tmpStack.pop)

for i in 1 .. 9:
    write(stdout, stacks[i].pop)

write(stdout, "\n")