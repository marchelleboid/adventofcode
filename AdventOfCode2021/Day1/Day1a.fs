module Day1a

open System.IO

let solver =
    let measurements = File.ReadLines "Inputs\\day1.txt" |> Seq.map int |> Seq.toList
    measurements[1..]
        |> List.mapi (fun i measurement -> if (measurement > measurements[i]) then 1 else 0)
        |> List.sum
        |> printfn "%d"