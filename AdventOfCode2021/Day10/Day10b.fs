module Day10b

open System.IO

let rec getErrorScore closureStack s =
    match s with
    | [] -> closureStack
    | x :: xs ->
        match x with
        | '(' | '[' | '{' | '<' -> getErrorScore (x :: closureStack) xs
        | ')' -> if List.head closureStack <> '('
                 then []
                 else getErrorScore (List.tail closureStack) xs
        | ']' -> if List.head closureStack <> '['
                 then []
                 else getErrorScore (List.tail closureStack) xs
        | '}' -> if List.head closureStack <> '{'
                 then []
                 else getErrorScore (List.tail closureStack) xs
        | '>' -> if List.head closureStack <> '<'
                 then []
                 else getErrorScore (List.tail closureStack) xs
        | _ -> getErrorScore closureStack xs // nope

let rec calculateScore closureStack score =
    match closureStack with
    | [] -> score
    | '(' :: xs -> calculateScore xs (score * 5UL + 1UL)
    | '[' :: xs -> calculateScore xs (score * 5UL + 2UL)
    | '{' :: xs -> calculateScore xs (score * 5UL + 3UL)
    | '<' :: xs -> calculateScore xs (score * 5UL + 4UL)
    | _ :: xs -> calculateScore xs score // nope

let solver =
    File.ReadLines "Inputs\\day10.txt"
        |> Seq.map Seq.toList
        |> Seq.map (fun x -> getErrorScore [] x)
        |> Seq.filter (fun x -> not (List.isEmpty x))
        |> Seq.map (fun x -> calculateScore x 0UL)
        |> Seq.sort
        |> fun x -> Seq.head (Seq.skip (Seq.length x / 2) x)
        |> printfn "%d"