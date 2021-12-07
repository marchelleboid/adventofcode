﻿module Day7a

open System.IO

let solver =
    File.ReadLines "Inputs\\day7.txt" 
        |> Seq.item 0
        |> fun x -> x.Split(",")
        |> Array.map int
        |> fun positions -> Array.mapi (fun i _ -> Array.sumBy (fun p -> abs (p - i)) positions) (Array.create (Array.max positions) 0)
        |> Array.min
        |> printfn "%d"