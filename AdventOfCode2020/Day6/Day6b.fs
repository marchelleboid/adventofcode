module Day6b

open System.IO
open System.Collections.Generic

let handleLine (current : Dictionary<char, int>) (line : string) =
    line.ToCharArray()
        |> Array.iter (
            fun x -> 
            (
                if current.ContainsKey(x) then
                    let toAdd = current.[x] + 1
                    current.Remove(x) |> ignore
                    current.Add(x, toAdd)
                else current.Add(x, 1))
            );
    current

let finishGroup (group : Dictionary<char, int>) lineCount  =
    group.Values |> Seq.filter (fun x -> x = lineCount) |> Seq.length

let rec parseLines total current currentLineCount lines =
    match lines with
    | [] -> total + (finishGroup current currentLineCount)
    | xs::rest -> 
        match xs with
        | "" -> parseLines (total + finishGroup current currentLineCount) (new Dictionary<char, int>()) 0 rest
        | _ -> parseLines total (handleLine current xs) (currentLineCount + 1) rest

let solver =
    File.ReadLines "Inputs\\day6.txt"
        |> List.ofSeq
        |> parseLines 0 (new Dictionary<char, int>()) 0
        |> printfn "%d"