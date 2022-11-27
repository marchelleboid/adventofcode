proc verify(candidate: int): bool =
    let candidateString = $candidate
    var hasAdjacentRepeated = false
    var currentRepeated = candidateString[0]
    var countRepeated = 1
    for i in 0 ..< candidateString.len:
        if i == 0:
            continue
        if candidateString[i] == currentRepeated:
            countRepeated += 1
        elif candidateString[i] < currentRepeated:
            return false
        else:
            if countRepeated == 2:
                hasAdjacentRepeated = true
            currentRepeated = candidateString[i]
            countRepeated = 1
    return hasAdjacentRepeated or countRepeated == 2

var count = 0
for i in 284639 .. 748759:
    if verify(i):
        count += 1

echo count