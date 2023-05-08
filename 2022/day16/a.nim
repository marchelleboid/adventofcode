import sets
import strscans
import strutils
import tables
import deques

type
    Room = object
        rate: int
        tunnels: seq[string]
        open: bool

var rooms = initTable[string, Room]()
var canOpen = initHashSet[string]()
var distances = initTable[string, Table[string, int]]()
for line in lines("input"):
    var id, tunnelsUnparsed: string
    var rate: int
    if not line.scanf("Valve $w has flow rate=$i; tunnels lead to valves $+", id, rate, tunnelsUnparsed):
        discard line.scanf("Valve $w has flow rate=$i; tunnel leads to valve $w", id, rate, tunnelsUnparsed)
    var tunnels = tunnelsUnparsed.split(", ")
    rooms[id] = Room(rate: rate, tunnels: tunnels, open: false)
    
    distances[id] = initTable[string, int]()
    for tunnel in tunnels:
        distances[id][tunnel] = 1
    distances[id][id] = 0
    
    if rate > 0:
        canOpen.incl(id)

for k in distances.keys:
    for i in distances.keys:
        for j in distances.keys:
            if distances[i].getOrDefault(j, 200) > distances[i].getOrDefault(k, 200) + distances[k].getOrDefault(j, 200):
                distances[i][j] = distances[i][k] + distances[k][j]

var maxPressure = 0

var opened = initHashSet[string]()
var queue = [("AA", 30, 0, opened)].toDeque
var cache = initTable[HashSet[string], int]()

while queue.len > 0:
    let (position, minutesLeft, pressure, alreadyOpen) = queue.popFirst

    let leftToOpen = canOpen - alreadyOpen
    for destination in leftToOpen:
        let distance = distances[position][destination]
        let time = minutesLeft - distance - 1
        if time <= 0:
            continue

        let newPressure = pressure + (rooms[destination].rate * time)
        maxPressure = max(newPressure, maxPressure)

        var openedCopy = alreadyOpen
        openedCopy.incl(destination)

        if cache.contains(openedCopy):
            if cache[openedCopy] > newPressure:
                continue

        queue.addLast((destination, time, newPressure, openedCopy))
        cache[openedCopy] = newPressure

echo maxPressure
