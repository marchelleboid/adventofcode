module Day5a

open System.IO

let addPointToMap state point =
    state
        |> Map.change point (fun x -> 
            match x with
            | Some _ -> Some (true)
            | None -> Some (false)
            )

let rec fillMap state pair =
    if fst pair = snd pair
    then
        addPointToMap state (fst pair)
    else
        pair 
            |> fun ((x1, y1), (x2, y2)) ->
                if x1 <> x2
                then if x1 < x2 then (x1 + 1, y1), (x2, y2) else (x1 - 1, y1), (x2, y2)
                else if y1 < y2 then (x1, y1 + 1), (x2, y2) else (x1, y1 - 1), (x2, y2)
            |> fillMap (addPointToMap state (fst pair))

let solver =
    File.ReadLines "Inputs\\day5.txt"
        |> Seq.map (fun line -> line.Split(" -> ") |> Array.map (fun x -> x.Split(",") |> Array.map int) |> Array.map (fun x -> x.[0], x.[1]))
        |> Seq.map (fun x -> x.[0], x.[1])
        |> Seq.filter (fun (p1, p2) -> fst p1 = fst p2 || snd p1 = snd p2)
        |> Seq.fold fillMap Map.empty<(int * int), bool>
        |> Map.filter (fun _ v -> v)
        |> Map.count
        |> printfn "%d"