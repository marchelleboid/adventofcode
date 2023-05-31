import math
import deques

func snafuToDec(snafu: string): int =
    var digit = 0
    var sum = 0
    for i in countdown(snafu.len - 1, 0):
        let c = snafu[i]
        case c:
        of '1':
            sum = sum + 5 ^ digit
        of '2':
            sum = sum + 2 * (5 ^ digit)
        of '-':
            sum = sum - 5 ^ digit
        of '=':
            sum = sum - 2 * (5 ^ digit)
        else:
            sum = sum
        inc digit
    return sum

proc decToSnafu(dec: int): string =
    var snafu = "".toDeque
    var remainingDec = dec
    var addOne = false
    while true:
        var divideResult = int(remainingDec / 5)
        var remainder = remainingDec mod 5
        if addOne:
            remainder += 1
            if remainder == 5:
                remainder = 0
            else:
                addOne = false
        case remainder:
        of 0:
            if divideResult != 0:
                snafu.addFirst('0')
        of 1:
            snafu.addFirst('1')
        of 2:
            snafu.addFirst('2')
        of 3:
            snafu.addFirst('=')
            if divideResult == 0:
                snafu.addFirst('1')
            else:
                addOne = true
        else:
            snafu.addFirst('-')
            if divideResult == 0:
                snafu.addFirst('1')
            else:
                addOne = true

        if divideResult == 0:
            break
        remainingDec = divideResult

    result = newStringOfCap(len(snafu))
    for ch in snafu:
        add(result, ch)
    return result

var count = 0
for line in lines("input"):
    count += snafuToDec(line)

echo decToSnafu(count)
