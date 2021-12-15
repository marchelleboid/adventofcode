module Day15b

open System.IO
open System.Collections.Generic

let isOnGrid x y endX endY =
    x >= 0 && y >= 0 && x <= endX && y <= endY

let riskLookup x y (grid : int[][]) =
    let xLength = Array.length (Array.head grid)
    let yLength = Array.length grid
    let baseRisk = grid[y % yLength][x % xLength]
    let scaledUp = baseRisk + x / xLength + y / yLength
    if scaledUp > 9 then scaledUp - 9 else scaledUp

let getMinPath x y toX toY (paths : Dictionary<int * int, int>) (queue : PriorityQueue<int * int, int>) (grid : int[][]) =
    let newDistance = (riskLookup toX toY grid) + paths.GetValueOrDefault((x, y), 0)
    let risk = paths.GetValueOrDefault((toX, toY), System.Int32.MaxValue)
    if newDistance < risk
    then queue.Enqueue((toX, toY), newDistance); (toX, toY), newDistance 
    else (toX, toY), risk

let updatePaths x y endX endY (paths : Dictionary<int * int, int>) (queue : PriorityQueue<int * int, int>) grid =
    [(x - 1, y);(x + 1, y);(x, y - 1);(x, y + 1)]
        |> List.filter (fun (x1, y1) -> isOnGrid x1 y1 endX endY)
        |> List.map (fun (x1, y1) -> getMinPath x y x1 y1 paths queue grid)
        |> List.iter (fun (p, risk) -> paths.set_Item(p, risk))
    paths.Remove((x, y)) |> ignore

let rec findPaths x y endX endY (paths : Dictionary<int * int, int>) queue grid =
    if y = endY && x = endX
    then paths
    else
        updatePaths x y endX endY paths queue grid
        let (nextX, nextY) = queue.Dequeue()
        findPaths nextX nextY endX endY paths queue grid

let findShortestPath grid =
    let endX = (Array.length (Array.head grid)) * 5 - 1
    let endY = Array.length grid * 5 - 1
    findPaths 0 0 endX endY (Dictionary<int * int, int>()) (PriorityQueue<int * int, int>()) grid
        |> fun p -> p.[(endX, endY)]

let solver =
    File.ReadLines "Inputs\\day15.txt"
        |> Seq.map (fun line -> line |> Seq.map (fun x -> (int x - int '0')) |> Seq.toArray)
        |> Seq.toArray
        |> findShortestPath
        |> printfn "%d"
