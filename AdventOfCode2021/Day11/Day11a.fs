module Day11a

open System.IO

let increasePoint column row (grid : (int * bool)[][]) =
    if row = -1 || column = -1 || row = 10 || column = 10
    then ()
    else grid[row][column] <- fst (grid[row][column]) + 1, snd (grid[row][column])

let countFlashes (grid : (int * bool)[][]) =
    let flashes = 
        grid
            |> Array.map (fun line -> Array.sumBy (fun (_, flashed) -> if flashed then 1 else 0) line)
            |> Array.sum
    for row in 0 .. 9 do
        for column in 0 .. 9 do
            if snd (grid[row][column])
            then grid[row][column] <- 0, false
    flashes

let rec flash column row hasFlashes (grid : (int * bool)[][]) =
    if row = 10
    then if hasFlashes
         then flash 0 0 false grid
         else 
            countFlashes grid
    else if column = 10
    then flash 0 (row + 1) hasFlashes grid
    else
        if fst (grid[row][column]) > 9 && not (snd (grid[row][column]))
        then
            increasePoint (column - 1) (row - 1) grid;
            increasePoint column (row - 1) grid;
            increasePoint (column + 1) (row - 1) grid;
            increasePoint (column - 1) row  grid;
            increasePoint (column + 1) row  grid;
            increasePoint (column - 1) (row + 1) grid;
            increasePoint column (row + 1) grid;
            increasePoint (column + 1) (row + 1) grid;
            grid[row][column] <- fst (grid[row][column]), true;
            flash (column + 1) row true grid
        else flash (column + 1) row hasFlashes grid

let rec runSteps stepsLeft flashCount grid =
    match stepsLeft with
    | 0 -> flashCount
    | _ -> 
        grid
            |> Array.map (fun line -> Array.map (fun (v, _) -> v + 1, false) line)
            |> fun g -> runSteps (stepsLeft - 1) ((flash 0 0 false g) + flashCount) g

let solver =
    File.ReadLines "Inputs\\day11.txt"
        |> Seq.map (fun line -> Seq.map (fun c -> (int c - int '0'), false) line |> Array.ofSeq)
        |> Array.ofSeq
        |> runSteps 100 0
        |> printfn "%d"