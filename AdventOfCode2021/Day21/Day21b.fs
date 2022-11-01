module Day21b

// Player 1 starting position: 3
// Player 2 starting position: 7

let getNextPosition move position = (position + move) % 10

// move 3 count 1
// move 4 count 3
// move 5 count 6
// move 6 count 7
// move 7 count 6
// move 8 count 3
// move 9 count 1

let moveCounts = [(3, 1L); (4, 3L); (5, 6L); (6, 7L); (7, 6L); (8, 3L); (9, 1L)]

let handleMove1 move moveCounts (universes, player1Wins, player2Wins) (p1position, p1score, p2position, p2score) universeCounts =
    let newUniverseCounts = moveCounts * universeCounts
    let newPosition = getNextPosition move p1position
    let newScore = p1score + newPosition + 1
    if newScore >= 21
    then universes, player1Wins + newUniverseCounts, player2Wins
    else (Map.change (newPosition, newScore, p2position, p2score) 
        (fun x -> 
            match x with
            | Some s -> Some (s + newUniverseCounts)
            | None -> Some (newUniverseCounts)
     ) universes), player1Wins, player2Wins

let handleMove2 move moveCounts (universes, player1Wins, player2Wins) (p1position, p1score, p2position, p2score) universeCounts =
    let newUniverseCounts = moveCounts * universeCounts
    let newPosition = getNextPosition move p2position
    let newScore = p2score + newPosition + 1
    if newScore >= 21
    then universes, player1Wins, player2Wins + newUniverseCounts
    else (Map.change (p1position, p1score, newPosition, newScore) 
        (fun x -> 
            match x with
            | Some s -> Some (s + newUniverseCounts)
            | None -> Some (newUniverseCounts)
    ) universes), player1Wins, player2Wins

let handlePlayer1 (universes, player1Wins, player2Wins) (p1position, p1score, p2position, p2score) count =
    List.fold (fun state (move, moveCounts) -> handleMove1 move moveCounts state (p1position, p1score, p2position, p2score) count) (universes, player1Wins, player2Wins) moveCounts

let handlePlayer2 (universes, player1Wins, player2Wins) (p1position, p1score, p2position, p2score) count =
    List.fold (fun state (move, moveCounts) -> handleMove2 move moveCounts state (p1position, p1score, p2position, p2score) count) (universes, player1Wins, player2Wins) moveCounts

let rec playGame (universes : Map<int * int * int * int, int64>) player1Turn player1Wins player2Wins =
    if Map.isEmpty universes
    then player1Wins, player2Wins
    else
        if player1Turn
        then
            let newUniverse, newPlayer1Wins, newPlayer2Wins = Map.fold handlePlayer1 (Map.empty<int * int * int * int, int64>, player1Wins, player2Wins) universes
            playGame newUniverse false newPlayer1Wins newPlayer2Wins
        else
            let newUniverse, newPlayer1Wins, newPlayer2Wins = Map.fold handlePlayer2 (Map.empty<int * int * int * int, int64>, player1Wins, player2Wins) universes
            playGame newUniverse true newPlayer1Wins newPlayer2Wins

let solver =
    playGame (Map [((2, 0, 6, 0), 1L)]) true 0L 0L
        |> printfn "%A"