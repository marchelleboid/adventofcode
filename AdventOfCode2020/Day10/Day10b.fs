module Day10b

open System.IO

let rec groupAdapters index current output adapters =
    if index = List.length adapters then current :: output
    else
        if index = 0 then groupAdapters 1 [0] List.empty adapters
        else 
            let value = adapters.[index]
            match value - adapters.[index - 1] with
            | 3 -> groupAdapters (index + 1) [value] (current :: output) adapters
            | _ -> groupAdapters (index + 1) (value :: current) output adapters

let calculateSublistCombinations sublist =
    match List.length sublist with
    | 1 | 2 -> uint64 1
    | 3 -> uint64 2
    | 4 -> uint64 4
    | 5 -> uint64 7
    | _ -> printfn "ahh"; uint64 0

let solver =
    let adapters = File.ReadLines "Inputs\\day10.txt" |> Seq.map int |> Seq.sort |> Seq.toList
    0 :: adapters
        |> groupAdapters 0 List.empty List.empty
        |> List.map calculateSublistCombinations
        |> List.reduce (*)
        |> printfn "%d"