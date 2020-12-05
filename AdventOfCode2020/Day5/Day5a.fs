module Day5a

open System.IO

let rec binarySearch code low high =
    match code with
    | [] -> low
    | x::rest ->
        match x with
        | 'F' | 'L' -> binarySearch rest low ((high + low) / 2)
        | 'B' | 'R' -> binarySearch rest (((high + low) / 2) + 1) high
        | _ -> -1

let getSeatId (code : string) =
    (binarySearch (code.[0..6] |> Seq.toList) 0 127) * 8 + (binarySearch (code.[7..9] |> Seq.toList) 0 7)

let solver =
    File.ReadLines "Inputs\\day5.txt"
        |> Seq.map getSeatId
        |> Seq.max
        |> printfn "%d"
