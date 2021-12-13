module Day13a

open System.IO

let foldValue valueToFold foldAt =
    if valueToFold > foldAt
    then foldAt - (valueToFold - foldAt)
    else valueToFold

let applyFold points fold =
    if fst fold = 'x'
    then 
        points
            |> List.map (fun (x, y) -> foldValue x (snd fold), y)
    else
        points
            |> List.map (fun (x, y) -> x, foldValue y (snd fold))

let solver =
    File.ReadLines "Inputs\\day13.txt"
        |> Seq.fold (fun (points, folds) line -> if Seq.isEmpty line then points, folds elif Seq.contains ',' line then points @ [line], folds else points, folds @ [line]) ([], [])
        |> fun (points, folds) -> List.map (fun (p : string) -> p.Split(",")) points, List.map (fun (f : string) -> f.Split("=")) folds
        |> fun (points, folds) -> List.map (fun p -> int (Array.item 0 p), int (Array.item 1 p)) points, List.map (fun f -> (if Seq.contains 'x' (Array.item 0 f) then 'x' else 'y'), int (Array.item 1 f)) folds
        |> fun (points, folds) -> applyFold points (List.head folds)
        |> Set.ofList
        |> Set.count
        |> printfn "%d"