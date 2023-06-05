import algorithm
import deques
import locks
import sequtils
import strutils
import ../intcode/computer

# Run like `nim --threadAnalysis:off c -r b.nim`

let program = map(readFile("input").strip().split(","), parseInt)
var phases = @[5, 6, 7, 8, 9]
var maxThrust = low(int)
while true:
    var threads: array[0..4, Thread[int]]
    var locks: array[0..4, Lock]
    var conds: array[0..4, Cond]
    for i in 0..4:
        initLock(locks[i])
        initCond(conds[i])
    
    var inputDeques: array[0..4, Deque[int]]

    for i, phase in phases:
        inputDeques[i].addLast(phase)
        if i == 0:
            inputDeques[0].addLast(0)

        proc threadFunc(index: int) {.thread.} =
            let inputFunction = proc(): int =
                if inputDeques[index].len > 0:
                    result = inputDeques[index].popFirst
                else:
                    acquire(locks[index])
                    wait(conds[index], locks[index])
                    result = inputDeques[index].popFirst
                    release(locks[index])
            let outputFunction = proc(output: int) = 
                var nextIndex = (index + 1) mod 5
                acquire(locks[nextIndex])
                inputDeques[nextIndex].addLast(output)
                signal(conds[nextIndex])
                release(locks[nextIndex])
            var intCodeComputer: IntCodeComputer = initComputer(program, inputFunction, outputFunction)
            intCodeComputer.runProgram

        createThread(threads[i], threadFunc, i)

    joinThreads(threads)
    let thrust = inputDeques[0].popFirst
    maxThrust = max(maxThrust, thrust)

    for i in 0..4:
        deinitCond(conds[i])
        deinitLock(locks[i])

    if not phases.nextPermutation():
        break

echo maxThrust
