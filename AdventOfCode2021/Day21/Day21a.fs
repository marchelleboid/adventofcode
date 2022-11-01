module Day21a

// Player 1 starting position: 3
// Player 2 starting position: 7

let getNextPosition nextRoll position =
    (position + (nextRoll + 1) + ((nextRoll + 1) % 100 + 1) + ((nextRoll + 2) % 100 + 1)) % 10

let rec playGame nextRoll player1Score player1Position player2Score player2Position turnsPlayed player1Turn =
    if player1Score >= 1000
    then player2Score * turnsPlayed * 3
    elif player2Score >= 1000
    then player1Score * turnsPlayed * 3
    else
        if player1Turn
        then 
            let nextPosition = getNextPosition nextRoll player1Position
            playGame ((nextRoll + 3) % 100) (player1Score + nextPosition + 1) nextPosition player2Score player2Position (turnsPlayed + 1) false
        else
            let nextPosition = getNextPosition nextRoll player2Position
            playGame ((nextRoll + 3) % 100)  player1Score player1Position (player2Score + nextPosition + 1) nextPosition (turnsPlayed + 1) true

let solver =
    playGame 0 0 2 0 6 0 true |> printfn "%d"