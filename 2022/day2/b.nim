import strutils
import tables

const WinScores = {"X": 0, "Y": 3, "Z": 6}.toTable

proc scoreRound(opponent: string, player: string): int =
    var moveScore = 0
    if opponent == "A": # Rock
        if player == "X":
            moveScore = 3
        elif player == "Y":
            moveScore = 1
        else:
            moveScore = 2
    elif opponent == "B": # Paper
        if player == "X":
            moveScore = 1
        elif player == "Y":
            moveScore = 2
        else:
            moveScore = 3
    else: # Scissors
        if player == "X":
            moveScore = 2
        elif player == "Y":
            moveScore = 3
        else:
            moveScore = 1
    return moveScore + WinScores.getOrDefault(player)

var score = 0
for line in lines("input"):
    let splitLine = line.strip.split(' ')
    score += scoreRound(splitLine[0], splitLine[1])

echo score