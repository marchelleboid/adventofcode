module Day2a

open System
open System.IO

type PasswordCheck = {atLeast: int; atMost: int; c: char; password: string}
let parseLine (str : string) =
    let parts = str.Split("-: ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries)
    {atLeast = int parts.[0]; atMost = int parts.[1]; c = parts.[2].[0]; password = parts.[3]}

let isValid passwordCheck =
    let count = passwordCheck.password |> Seq.filter ((=) passwordCheck.c) |> Seq.length
    count >= passwordCheck.atLeast && count <= passwordCheck.atMost

let solver =
    File.ReadLines "Inputs\\day2.txt"
        |> Seq.map parseLine
        |> Seq.filter isValid
        |> Seq.length
        |> printfn "%d"
    