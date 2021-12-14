module Day14b

open System.IO

let updateMapWithPair firstChar secondChar amount table =
    table
        |> Map.change (System.String [|firstChar;secondChar|]) (fun x ->
            match x with
            | Some v -> Some (v + amount)
            | None -> Some (amount)
        )

let updateMapWithChar c amount table =
    table
        |> Map.change (System.String [|c|]) (fun x ->
            match x with
            | Some v -> Some (v + amount)
            | None -> Some (amount)
        )

let rec templateToCounts template counts =
    match template with
    | [] -> counts
    | a :: [] -> counts |> updateMapWithChar a 1UL
    | a :: b :: rest ->
        counts
            |> updateMapWithPair a b 1UL
            |> updateMapWithChar a 1UL
            |> templateToCounts (b :: rest)

let performInsertion counts inserts =
    counts
        |> Map.fold (fun newCounts (x : string) count ->
            if x.Length = 2
            then
                let insertChar = Map.find x inserts |> Seq.exactlyOne
                newCounts
                    |> updateMapWithPair (Seq.item 0 x) insertChar count
                    |> updateMapWithPair insertChar (Seq.item 1 x) count
                    |> updateMapWithChar insertChar count
            else newCounts
        ) (Map.filter (fun x _ -> x.Length = 1) counts)

let rec performInsertions counts n inserts =
    match n with 
    | 0 -> counts
    | _ -> performInsertions (performInsertion counts inserts) (n - 1) inserts

let findRange counts =
    counts
        |> Map.values
        |> Seq.sort
        |> Seq.toList
        |> fun x -> (List.last x) - (List.head x)

let solver =
    let lines = File.ReadLines "Inputs\\day14.txt"
    let template = Seq.item 0 lines
    Seq.skip 2 lines
        |> Seq.toList
        |> List.map (fun x -> x.Split(" -> "))
        |> List.fold (fun inserts splitString -> inserts |> Map.add (Array.item 0 splitString) (Array.item 1 splitString)) Map.empty<string, string>
        |> performInsertions (templateToCounts (Seq.toList template) Map.empty<string, uint64>) 40
        |> Map.filter (fun x _ -> x.Length = 1)
        |> findRange
        |> printfn "%d"