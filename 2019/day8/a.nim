import sequtils

let f = open("input")
let line = f.readLine
f.close()

let layerCount = int(len(line) / 150)
let layers = toSeq(line).distribute(layerCount, false)

var lowestZeroCount = high(int)
var output = 0
for layer in layers:
    var zeroCount, oneCount, twoCount = 0
    for c in layer:
        if c == '0':
            zeroCount += 1
            if zeroCount >= lowestZeroCount:
                break
        elif c == '1':
            oneCount += 1
        else:
            twoCount += 1
    if zeroCount < lowestZeroCount:
        lowestZeroCount = zeroCount
        output = oneCount*twoCount

echo output
