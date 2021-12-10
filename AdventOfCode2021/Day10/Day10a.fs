module Day10a

open System.IO

let rec getErrorScore closureStack s =
    match s with
    | [] -> 0
    | x :: xs ->
        match x with
        | '(' | '[' | '{' | '<' -> getErrorScore (x :: closureStack) xs
        | ')' -> if List.head closureStack <> '('
                 then 3
                 else getErrorScore (List.tail closureStack) xs
        | ']' -> if List.head closureStack <> '['
                 then 57
                 else getErrorScore (List.tail closureStack) xs
        | '}' -> if List.head closureStack <> '{'
                 then 1197
                 else getErrorScore (List.tail closureStack) xs
        | '>' -> if List.head closureStack <> '<'
                 then 25137
                 else getErrorScore (List.tail closureStack) xs
        | _ -> getErrorScore closureStack xs // nope

let solver =
    File.ReadLines "Inputs\\day10.txt"
        |> Seq.map Seq.toList
        |> Seq.map (fun x -> getErrorScore [] x)
        |> Seq.filter (fun x -> x <> 0)
        |> Seq.sum
        |> printfn "%d"