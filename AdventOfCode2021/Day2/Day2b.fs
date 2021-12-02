module Day2b

open System.IO

type Submarine = {depth: int; horizontal: int; aim: int}

let moveSub sub instruction =
    match fst instruction with
    | "forward" -> {sub with horizontal = sub.horizontal + snd instruction; depth = sub.depth + sub.aim * snd instruction}
    | "down" -> {sub with aim = sub.aim + snd instruction}
    | "up" -> {sub with aim = sub.aim - snd instruction}
    | _ -> sub

let solver =
    File.ReadLines "Inputs\\day2.txt"
        |> Seq.map (fun x -> x.Split(" "))
        |> Seq.map (fun x -> x[0], int x[1])
        |> Seq.fold moveSub {depth = 0; horizontal = 0; aim = 0}
        |> fun sub -> sub.depth * sub.horizontal
        |> printfn "%d"