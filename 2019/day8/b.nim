import sequtils

let f = open("input")
let line = f.readLine
f.close()

let layerCount = int(len(line) / 150)
let layers = toSeq(line).distribute(layerCount, false)

var finalLayer: seq[char] = @[]
for i in 0 ..< 150:
    for layer in layers:
        if layer[i] != '2':
            finalLayer.add(layer[i])
            break

for i, c in finalLayer:
    if i %% 25 == 0:
        stdout.write "\n"
    if c == '0':
        stdout.write " "
    else:
        stdout.write "*"
stdout.write "\n"