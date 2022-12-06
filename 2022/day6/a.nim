import sets

let datastream = readFile("input")

var previousChars = newSeqOfCap[char](4)
var count = 0
for c in datastream:
    if previousChars.len != 4:
        previousChars.add(c)
        count += 1
    else:
        let theSet = toHashSet(previousChars)
        if theSet.len == 4:
            break
        previousChars.delete(0)
        previousChars.add(c)
        count += 1
    
echo count