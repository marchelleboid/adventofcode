module Day9b

open System.IO

let rec countBasin x y (lines : int[][]) =
    if x < 0 || x >= Array.length lines[0] || y < 0 || y >= (Array.length lines)
    then 0
    else if lines[y][x] = 9
    then 0
    else 
    lines[y][x] <- 9;
    1 + (countBasin (x + 1) y lines) + (countBasin (x - 1) y lines) + (countBasin x (y + 1) lines) + (countBasin x (y - 1) lines)

let rec countBasins x y basins (lines : int[][]) =
    if x >= Array.length lines[0]
    then countBasins 0 (y + 1) basins lines
    else if y >= (Array.length lines)
    then basins
    else if lines[y][x] = 9
    then countBasins (x + 1) y basins lines
    else
        countBasins (x + 1) y ((countBasin x y lines) :: basins) lines

let solver =
    let lines = 
        File.ReadLines "Inputs\\day9.txt"
            |> Seq.map (fun line -> Seq.map (fun c -> (int c - int '0')) line |> Array.ofSeq)
            |> Array.ofSeq
    countBasins 0 0 [] lines
        |> List.sortDescending
        |> List.take 3
        |> List.fold (fun accum x -> accum * x) 1
        |> printfn "%d"