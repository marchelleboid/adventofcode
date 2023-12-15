import sequtils
import strutils

let line = readLines("input.txt", 1)

var hashMap: array[256, seq[tuple[label: string, focalLength: int]]]
for i in 0 .. 255:
    hashMap[i] = @[]

for step in line[0].split(","):
    var label: string
    var focalLength = -1
    if step.contains('='):
        label = step.split("=")[0]
        focalLength = parseInt(step.split("=")[1])
    else:
        label = step[0 .. ^2]

    var hash = 0
    for c in label:
        hash += ord(c)
        hash *= 17
        hash = hash mod 256

    var index = -1
    for i, lens in hashMap[hash]:
        if lens.label == label:
            index = i
            break
   
    var newBox = hashMap[hash]
    if focalLength == -1:
        if index != -1:
            newBox.delete(index .. index)
    else:
        let newLabel = (label: label, focalLength: focalLength)
        if index == -1:
            newBox.add(newLabel)
        else:
            newBox[index] = newLabel
    hashMap[hash] = newBox

var count = 0
for i in 0 .. 255:
    let box = hashMap[i]
    for j, lens in box:
        count += (i + 1) * (j + 1) * lens.focalLength

echo count