module Day4a

open System
open System.IO
open System.Collections.Generic

let rec combinePair xs =
    match xs with
    | [] | [_] -> []
    | x1::x2::rest -> (x1, x2) :: (combinePair rest)

let handleLine (current : Dictionary<string, string>) (line : string) =
    let zipped = line.Split(" :".ToCharArray(), StringSplitOptions.RemoveEmptyEntries) |> Array.toList |> combinePair
    zipped |> List.iter (fun (k, v) -> current.Add(k, v))
    current

let rec parseLines passports current lines =
    match lines with
    | [] -> (current :: passports)
    | x::rest ->
        match x with
        | "" -> parseLines (current :: passports) (new Dictionary<string, string>()) rest
        | _ -> parseLines passports (handleLine current x) rest

let isValidPassport (passport : Dictionary<string, string>) =
    passport.Count = 8 || (passport.Count = 7 && not (passport.ContainsKey("cid")))

let solver =
    File.ReadLines "Inputs\\day4.txt"
        |> List.ofSeq
        |> parseLines List.empty<Dictionary<string, string>> (new Dictionary<string, string>())
        |> List.filter isValidPassport
        |> List.length
        |> printfn "%d"