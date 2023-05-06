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

let yValue = 2000000
var count = 0
for i in mostLeft .. mostRight:
    var countIt = false
    for sensor in sensors:
        if i == sensor.beaconX and yValue == sensor.beaconY:
            countIt = false
            break
        let distanceFrom = abs(i - sensor.x) + abs(yValue - sensor.y)
        if distanceFrom != 0 and distanceFrom <= sensor.distance:
            countIt = true
    if countIt:
        count += 1

echo count