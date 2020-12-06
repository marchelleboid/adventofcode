module Day6a

open System.IO

let handleLine current (line : string) =
    line.ToCharArray()
        |> Array.fold (fun x y -> Set.add y x) current

let rec parseLines forms current lines =
    match lines with
    | [] -> (current :: forms)
    | xs::rest -> 
        match xs with
        | "" -> parseLines (current :: forms) Set.empty rest
        | _ -> parseLines forms (handleLine current xs) rest

let solver =
    File.ReadLines "Inputs\\day6.txt"
        |> List.ofSeq
        |> parseLines List.empty<Set<char>> Set.empty
        |> List.sumBy (fun x -> Set.count x)
        |> printfn "%d"