import strutils

var xRegister = 1
var cycle = 0

proc drawPixel() =
    let horizontalPosition = cycle mod 40
    if horizontalPosition >= xRegister - 1 and horizontalPosition <= xRegister + 1:
        write(stdout, "#")
    else:
        write(stdout, ".")

    if horizontalPosition == 39:
        write(stdout, "\n")

for line in lines("input"):
    let splitLine = line.strip.split(" ")
    let command = splitLine[0]
    if command == "noop":
        drawPixel()
        cycle += 1
    else:
        let value = splitLine[1].parseInt
        drawPixel()
        cycle += 1
        drawPixel()
        cycle += 1
        xRegister += value
