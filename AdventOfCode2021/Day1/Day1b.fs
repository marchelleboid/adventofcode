module Day1b

open System.IO

let solver =
    let measurements = File.ReadLines "Inputs\\day1.txt" |> Seq.map int |> Seq.toList
    measurements[3..]
        |> List.mapi (fun i _ -> 
            if ((measurements[i + 1] + measurements[i + 2] + measurements[i + 3]) > (measurements[i] + measurements[i + 1] + measurements[i + 2]))
                then 1 else 0
                )
        |> List.sum
        |> printfn "%d"