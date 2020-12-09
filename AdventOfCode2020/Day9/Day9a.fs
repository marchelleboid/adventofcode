module Day9a

open System.IO

let rec isValueWeak value preamble =
    match preamble with
    | [] -> true
    | xs::rest -> 
        if List.contains (value - xs) rest then false
        else isValueWeak value rest

let rec findFirstWeakness index preamble (inputs : list<uint64>) =
    let valueToCheck = inputs.[index]
    if isValueWeak valueToCheck preamble then valueToCheck
    else findFirstWeakness (index + 1) (valueToCheck :: preamble.[.. preamble.Length-1]) inputs

let solver =
    let inputs = File.ReadLines "Inputs\\day9.txt" |> Seq.map uint64 |> Seq.toList
    let preamble = List.take 25 inputs
    findFirstWeakness 0 preamble inputs.[25..] |> printfn "%d"
