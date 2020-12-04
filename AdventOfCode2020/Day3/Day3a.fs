module Day3a

open System.IO

let rec countTrees x y count (grid : seq<char []>) =
    if y >= Seq.length grid then count
    else
        let row = (Seq.item y grid)
        if row.[x] = '#' then countTrees ((x + 3) % row.Length) (y + 1) (count + 1) grid
        else countTrees ((x + 3) % row.Length) (y + 1) count grid

let solver =
    File.ReadLines "Inputs\\day3.txt"
        |> Seq.map (fun (l : string) -> l.ToCharArray())
        |> countTrees 3 1 0
        |> printfn "%d"