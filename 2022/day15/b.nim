import strscans

type
    Sensor = object
        x: int
        y: int
        beaconX: int
        beaconY: int
        distance: int

func parseLine(line: string): Sensor =
    var x, y, beaconX, beaconY: int
    discard line.scanf("Sensor at x=$i, y=$i: closest beacon is at x=$i, y=$i", x, y, beaconX, beaconY)
    let distance = abs(x - beaconX) + abs(y - beaconY)
    return Sensor(x: x, y: y, beaconX: beaconX, beaconY: beaconY, distance: distance)

var mostLeft = high(int)
var mostRight = low(int)
var sensors: seq[Sensor] 
for line in lines("input"):
    let sensor = parseLine(line)
    sensors.add(sensor)
    mostLeft = min(mostLeft, sensor.x - sensor.distance)
    mostRight = max(mostRight, sensor.x + sensor.distance)

for y in 0 .. 4000000:
    var endIt = false
    var x = 0
    while x <= 4000000:
        var countIt = true
        for sensor in sensors:
            if x == sensor.beaconX and y == sensor.beaconY:
                countIt = false
                x += 1
                break
            let distanceFrom = abs(x - sensor.x) + abs(y - sensor.y)
            if distanceFrom <= sensor.distance:
                x += sensor.distance - distanceFrom + 1
                countIt = false
                break
        if countIt:
            let tuning = 4000000 * uint64(x) + uint64(y)
            echo tuning
            endIt = true
            break
    if endIt:
        break