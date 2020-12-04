module Day2b

open System
open System.IO

type PasswordCheck = {pos1: int; pos2: int; c: char; password: string}
let parseLine (str : string) =
    let parts = str.Split("-: ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries)
    {pos1 = int parts.[0]; pos2 = int parts.[1]; c = parts.[2].[0]; password = parts.[3]}

let isValid passwordCheck =
    let pos1Valid = passwordCheck.password.[passwordCheck.pos1 - 1] = passwordCheck.c
    let pos2Valid = passwordCheck.password.[passwordCheck.pos2 - 1] = passwordCheck.c
    not ((pos1Valid && pos2Valid) || (not pos1Valid && not pos2Valid))

let solver =
    File.ReadLines "Inputs\\day2.txt"
        |> Seq.map parseLine
        |> Seq.filter isValid
        |> Seq.length
        |> printfn "%d"
    