import sequtils
import strutils

proc pythonMod(n, M: int64): int64 = ((n mod M) + M) mod M

let key = int64(811589153)

var initial: seq[int64]
for line in lines("input"):
    initial.add(int64(line.parseInt) * key)

var moved: seq[(int64, int)]
for index, item in initial:
    moved.add((item, index))

for _ in 1 .. 10:
    for index, _ in initial:
        var movedIndex: int
        var movedItem: (int64, int)
        for index2, x in moved:
            if x[1] == index:
                movedIndex = index2
                movedItem = x
                break
        var newIndex = pythonMod((int64(movedIndex) + movedItem[0]), int64(moved.len - 1))
        moved.delete(movedIndex .. movedIndex)
        if newIndex == 0:
            moved.add(movedItem)
        else:
            moved.insert(movedItem, newIndex)

var zeroPosition: int
for index, item in moved:
    if item[0] == 0:
        zeroPosition = index
        break

let index1000 = (zeroPosition + 1000) mod moved.len
let index2000 = (zeroPosition + 2000) mod moved.len
let index3000 = (zeroPosition + 3000) mod moved.len

echo moved[index1000][0] + moved[index2000][0] + moved[index3000][0]