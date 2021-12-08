module Day8a

open System.IO

let solver =
    File.ReadLines "Inputs\\day8.txt"
        |> Seq.map (fun x -> x.Split(" | ").[1])
        |> Seq.map (fun x -> x.Split(" "))
        |> Seq.map (fun x -> 
            (Array.filter (fun y -> match String.length y with
                                    | 2 | 3 | 4 | 7 -> true
                                    | _ -> false)
                                    x))
        |> Seq.sumBy (fun x -> Array.length x)
        |> printfn "%d"