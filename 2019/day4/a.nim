proc verify(candidate: int): bool =
    let candidateString = $candidate
    var hasAdjacentRepeated = false
    for i in 0 ..< (candidateString.len - 1):
        if candidateString[i] == candidateString[i + 1]:
            hasAdjacentRepeated = true
        elif candidateString[i] > candidateString[i + 1]:
            return false
    return hasAdjacentRepeated

var count = 0
for i in 284639 .. 748759:
    if verify(i):
        count += 1

echo count