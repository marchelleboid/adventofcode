import strutils
import tables

const MoveScores = {"X": 1, "Y": 2, "Z": 3}.toTable

proc scoreRound(opponent: string, player: string): int =
    var winScore = 0
    if opponent == "A": # Rock
        if player == "X":
            winScore = 3
        elif player == "Y":
            winScore = 6
        else:
            winScore = 0
    elif opponent == "B": # Paper
        if player == "X":
            winScore = 0
        elif player == "Y":
            winScore = 3
        else:
            winScore = 6
    else: # Scissors
        if player == "X":
            winScore = 6
        elif player == "Y":
            winScore = 0
        else:
            winScore = 3
    return winScore + MoveScores.getOrDefault(player)

var score = 0
for line in lines("input"):
    let splitLine = line.strip.split(' ')
    score += scoreRound(splitLine[0], splitLine[1])

echo score