import algorithm
import strutils

var count = 0
for line in lines("input"):
    var firstDigit: char
    var lastDigit: char
    for c in line:
        if c.isDigit:
            firstDigit = c
            break
    for c in line.reversed:
        if c.isDigit:
            lastDigit = c
            break
    count += parseInt($firstDigit & $lastDigit)

echo count