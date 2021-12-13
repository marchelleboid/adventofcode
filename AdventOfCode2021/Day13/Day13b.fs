module Day13b

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

let drawPoints points =
    let maxX = Set.fold (fun m p -> if fst p > m then fst p else m) 0 points
    let maxY = Set.fold (fun m p -> if snd p > m then snd p else m) 0 points
    for y in 0 .. maxY do
        for x in 0 .. maxX do
            if Set.contains (x, y) points
            then printf "#"
            else printf "."
        printfn ""

let solver =
    File.ReadLines "Inputs\\day13.txt"
        |> Seq.fold (fun (points, folds) line -> if Seq.isEmpty line then points, folds elif Seq.contains ',' line then points @ [line], folds else points, folds @ [line]) ([], [])
        |> fun (points, folds) -> List.map (fun (p : string) -> p.Split(",")) points, List.map (fun (f : string) -> f.Split("=")) folds
        |> fun (points, folds) -> List.map (fun p -> int (Array.item 0 p), int (Array.item 1 p)) points, List.map (fun f -> (if Seq.contains 'x' (Array.item 0 f) then 'x' else 'y'), int (Array.item 1 f)) folds
        |> fun (points, folds) -> List.fold (fun pts fold -> applyFold pts fold) points folds
        |> Set.ofList
        |> drawPoints
        