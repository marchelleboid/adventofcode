import strutils

var count = 0
for line in lines("input"):
    let setSplit = line.split(": ")[1].split(";")

    var blueNeeded, greenNeeded, redNeeded = 0
    for st in setSplit:
        let cubeSplit = st.split(",")
        for cube in cubeSplit:
            var amount = parseInt(cube.strip.split(" ")[0])
            var color = cube.strip.split(" ")[1]

            if color == "blue":
                blueNeeded = max(amount, blueNeeded)
            elif color == "red":
                redNeeded = max(amount, redNeeded)
            elif color == "green":
                greenNeeded = max(amount, greenNeeded)
    
    let power = blueNeeded * greenNeeded * redNeeded
    count += power

echo count