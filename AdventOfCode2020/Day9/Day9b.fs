module Day9b

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

let rec findSumIndices start last current target (inputs : list<uint64>) =
    if current = target then start, last
    else if current < target then
        findSumIndices start (last + 1) (current + inputs.[last + 1]) target inputs
    else
        findSumIndices (start + 1) last (current - inputs.[start]) target inputs

let solver =
    let inputs = File.ReadLines "Inputs\\day9.txt" |> Seq.map uint64 |> Seq.toList
    let preamble = List.take 25 inputs
    let weakness = findFirstWeakness 0 preamble inputs.[25..]
    let start, last = findSumIndices 0 1 (inputs.[0] + inputs.[1]) weakness inputs
    List.min inputs.[start..last] + List.max inputs.[start..last] |> printfn "%d"