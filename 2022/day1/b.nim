import strutils
import heapqueue

var workers = newSeq[int](0)
var currentCalories = 0
for line in lines("input"):
    let stripped = line.strip
    if stripped.isEmptyOrWhitespace:
        workers.add(-1 * currentCalories)
        currentCalories = 0
    else:
        currentCalories += stripped.parseInt

workers.add(-1 * currentCalories)

var heap = workers.toHeapQueue

let maxCalories = heap.pop + heap.pop + heap.pop

echo (-1 * maxCalories)