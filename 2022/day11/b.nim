type
    Monkey = object
        items: seq[uint64]
        operation: proc(worryLevel: uint64): uint64
        testDivisible: uint64
        testTrueDestination: int
        testFalseDestination: int
        itemsInspected: int

proc addItem(self: var Monkey, item: uint64) =
    self.items.add(item)

proc popItem(self: var Monkey): uint64 =
    if self.items.len == 0:
        return 0
    let item = self.items[0]
    self.items.delete(0)
    self.itemsInspected += 1
    return item

proc getMonkeyToThrowTo(self: Monkey, item: uint64): int =
    if item mod self.testDivisible == 0:
        return self.testTrueDestination
    else:
        return self.testFalseDestination

var monkeys: array[8, Monkey]
monkeys[0] = Monkey(
    items: @[54, 53],
    operation: proc(worryLevel: uint64): uint64 = worryLevel * 3,
    testDivisible: 2,
    testTrueDestination: 2,
    testFalseDestination: 6,
    itemsInspected: 0
)
monkeys[1] = Monkey(
    items: @[95, 88, 75, 81, 91, 67, 65, 84],
    operation: proc(worryLevel: uint64): uint64 = worryLevel * 11,
    testDivisible: 7,
    testTrueDestination: 3,
    testFalseDestination: 4,
    itemsInspected: 0
)
monkeys[2] = Monkey(
    items: @[76, 81, 50, 93, 96, 81, 83],
    operation: proc(worryLevel: uint64): uint64 = worryLevel + 6,
    testDivisible: 3,
    testTrueDestination: 5,
    testFalseDestination: 1,
    itemsInspected: 0
)
monkeys[3] = Monkey(
    items: @[83, 85, 85, 63],
    operation: proc(worryLevel: uint64): uint64 = worryLevel + 4,
    testDivisible: 11,
    testTrueDestination: 7,
    testFalseDestination: 4,
    itemsInspected: 0
)
monkeys[4] = Monkey(
    items: @[85, 52, 64],
    operation: proc(worryLevel: uint64): uint64 = worryLevel + 8,
    testDivisible: 17,
    testTrueDestination: 0,
    testFalseDestination: 7,
    itemsInspected: 0
)
monkeys[5] = Monkey(
    items: @[57],
    operation: proc(worryLevel: uint64): uint64 = worryLevel + 2,
    testDivisible: 5,
    testTrueDestination: 1,
    testFalseDestination: 3,
    itemsInspected: 0
)
monkeys[6] = Monkey(
    items: @[60, 95, 76, 66, 91],
    operation: proc(worryLevel: uint64): uint64 = worryLevel * worryLevel,
    testDivisible: 13,
    testTrueDestination: 2,
    testFalseDestination: 5,
    itemsInspected: 0
)
monkeys[7] = Monkey(
    items: @[65, 84, 76, 72, 79, 65],
    operation: proc(worryLevel: uint64): uint64 = worryLevel + 5,
    testDivisible: 19,
    testTrueDestination: 6,
    testFalseDestination: 0,
    itemsInspected: 0
)

for _ in 0 .. 9999:
    for i in 0 ..< monkeys.len:
        var currentMonkey = monkeys[i]
        var nextItem = currentMonkey.popItem()
        while nextItem > 0:
            nextItem = currentMonkey.operation(nextItem)
            nextItem = nextItem mod 9699690
            var destinationMonkey = currentMonkey.getMonkeyToThrowTo(nextItem)
            monkeys[destinationMonkey].addItem(nextItem)
            nextItem = currentMonkey.popItem()
        monkeys[i] = currentMonkey

var maxInspections, nextMaxInspections = 0
for i in 0 ..< monkeys.len:
    if monkeys[i].itemsInspected > maxInspections:
        nextMaxInspections = maxInspections
        maxInspections = monkeys[i].itemsInspected
    elif monkeys[i].itemsInspected > nextMaxInspections:
        nextMaxInspections = monkeys[i].itemsInspected

echo uint64(maxInspections) * uint64(nextMaxInspections)