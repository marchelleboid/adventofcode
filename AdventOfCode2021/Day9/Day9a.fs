module Day9a

open System.IO

let addAbove row column lines =
    if row <> 0 
    then [List.item column (List.item (row - 1) lines)]
    else []

let addBelow row column lines points =
    if row <> (List.length lines - 1)
    then List.item column (List.item (row + 1) lines) :: points
    else points

let addLeft column line points =
    if column <> 0
    then List.item (column - 1) line :: points
    else points

let addRight column line points =
    if column <> (List.length line - 1)
    then List.item (column + 1) line :: points
    else points

let isLowPoint row column height line lines =
    let toCompare = 
        addAbove row column lines
        |> addBelow row column lines
        |> addLeft column line
        |> addRight column line
    if List.forall (fun x -> height < x) toCompare
    then height, true
    else height, false     

let solver =
    let lines = 
        File.ReadLines "Inputs\\day9.txt"
            |> Seq.map (fun line -> Seq.map (fun c -> (int c - int '0')) line |> Seq.toList)
            |> Seq.toList
    lines
        |> List.mapi 
            (fun row line -> List.mapi (fun column height -> isLowPoint row column height line lines) line)
        |> List.map (fun line -> List.filter (fun x -> snd x) line)
        |> List.map (fun line -> List.map (fun v -> fst v + 1) line |> List.sum)
        |> List.sum
        |> printfn "%d"