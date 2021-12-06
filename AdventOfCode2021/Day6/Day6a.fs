module Day6a

open System.IO

let rec simulateDays daysLeft fish =
    match daysLeft with
    | 0 -> fish
    | _ -> 
        (List.skip 1 fish) @ [List.item 0 fish]
            |> List.updateAt 6 (List.item 7 fish + List.item 0 fish)
            |> simulateDays (daysLeft - 1)

let solver =
    File.ReadLines "Inputs\\day6.txt" 
        |> Seq.item 0
        |> fun x -> x.Split(",")
        |> Array.map int
        |> Array.fold (fun state x -> List.updateAt x ((List.item x state) + 1) state) (List.init 9 (fun _ -> 0))
        |> simulateDays 80
        |> List.sum
        |> printfn "%d"