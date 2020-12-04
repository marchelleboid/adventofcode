module Day3b

open System.IO

let rec countTrees x y count xIncrease yIncrease (grid : seq<char []>) =
    if y >= Seq.length grid then count
    else
        let row = (Seq.item y grid)
        if row.[x] = '#' then countTrees ((x + xIncrease) % row.Length) (y + yIncrease) (count + 1) xIncrease yIncrease grid
        else countTrees ((x + xIncrease) % row.Length) (y + yIncrease) count xIncrease yIncrease grid

let solver =
    let grid = File.ReadLines "Inputs\\day3.txt" |> Seq.map (fun (l : string) -> l.ToCharArray())
    [(1,1); (3,1); (5,1); (7,1); (1,2) ]
        |> Seq.map (fun (x, y) -> countTrees x y 0 x y grid)
        |> Seq.map uint32
        |> Seq.reduce (fun a b -> a * b)
        |> printfn "%d"