module Day20a

open System
open System.IO
open System.Collections.Generic

let fillGrid y line (grid : Dictionary<int * int, bool>) =
    line |> Seq.iteri (fun x ch -> grid.set_Item((x, y), (ch = '#')))

let getLookup x y i (grid : Dictionary<int * int, bool>) =
    let borderPixelDefault = (i % 2 = 0)
    let mutable binaryString = ""
    if grid.GetValueOrDefault((x - 1, y - 1), borderPixelDefault) then binaryString <- binaryString + "1" else binaryString <- binaryString + "0"
    if grid.GetValueOrDefault((x, y - 1), borderPixelDefault) then binaryString <- binaryString + "1" else binaryString <- binaryString + "0"
    if grid.GetValueOrDefault((x + 1, y - 1), borderPixelDefault) then binaryString <- binaryString + "1" else binaryString <- binaryString + "0"
    if grid.GetValueOrDefault((x - 1, y), borderPixelDefault) then binaryString <- binaryString + "1" else binaryString <- binaryString + "0"
    if grid.GetValueOrDefault((x, y), borderPixelDefault) then binaryString <- binaryString + "1" else binaryString <- binaryString + "0"
    if grid.GetValueOrDefault((x + 1, y), borderPixelDefault) then binaryString <- binaryString + "1" else binaryString <- binaryString + "0"
    if grid.GetValueOrDefault((x - 1, y + 1), borderPixelDefault) then binaryString <- binaryString + "1" else binaryString <- binaryString + "0"
    if grid.GetValueOrDefault((x, y + 1), borderPixelDefault) then binaryString <- binaryString + "1" else binaryString <- binaryString + "0"
    if grid.GetValueOrDefault((x + 1, y + 1), borderPixelDefault) then binaryString <- binaryString + "1" else binaryString <- binaryString + "0"
    Convert.ToInt32(binaryString, 2)

let rec enhance algo i maxI baseX baseY (grid : Dictionary<int * int, bool>) =
    if i > maxI
    then grid.Values |> Seq.filter id |> Seq.length
    else
        let newGrid = Dictionary<int * int, bool>()
        for y in -i..baseY + i - 1 do
            for x in -i..baseX + i - 1 do
                let newValue = getLookup x y i grid
                newGrid.set_Item((x, y), ((Seq.item newValue algo) = '#'))
        enhance algo (i + 1) maxI baseX baseY newGrid

let solver =
    let lines = File.ReadLines "Inputs\\day20.txt"
    let algo = Seq.head lines
    let grid = Dictionary<int * int, bool>()
    lines
        |> Seq.skip 2
        |> Seq.iteri (fun y line -> fillGrid y line grid)
    grid
        |> enhance algo 1 2 (Seq.length (Seq.head (Seq.skip 2 lines))) (Seq.length (Seq.skip 2 lines))
        |> printfn "%d"
    