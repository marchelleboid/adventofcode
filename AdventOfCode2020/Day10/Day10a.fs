module Day10a

open System.IO

let rec count1And3 count1 count3 lst =
    match lst with
    | [] -> count1, count3
    | xs::rest when xs = 1 -> count1And3 (count1 + 1) count3 rest
    | xs::rest when xs = 3 -> count1And3 count1 (count3 + 1) rest
    | xs::rest -> count1And3 count1 count3 rest

let solver =
    let adapters = File.ReadLines "Inputs\\day10.txt" |> Seq.map int |> Seq.sort |> Seq.toList
    let count1, count3 = 
        adapters
        |> List.mapi (
            fun i adapter ->
                if i = 0 then adapter
                else adapter - adapters.[i - 1]
        )
        |> count1And3 0 0
    printfn "%d" (count1 * (count3 + 1))