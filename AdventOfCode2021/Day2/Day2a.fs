module Day2a

open System.IO

type Submarine = {depth: int; horizontal: int}

let moveSub sub instruction =
    match fst instruction with
    | "forward" -> {sub with horizontal = sub.horizontal + snd instruction}
    | "down" -> {sub with depth = sub.depth + snd instruction}
    | "up" -> {sub with depth = sub.depth - snd instruction}
    | _ -> sub

let solver =
    File.ReadLines "Inputs\\day2.txt"
        |> Seq.map (fun x -> x.Split(" "))
        |> Seq.map (fun x -> x[0], int x[1])
        |> Seq.fold moveSub {depth = 0; horizontal = 0}
        |> fun sub -> sub.depth * sub.horizontal
        |> printfn "%d"