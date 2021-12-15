module Day15a

open System.IO
open System.Collections.Generic

let isOnGrid x y endX endY =
    x >= 0 && y >= 0 && x <= endX && y <= endY

let getMinPath x y toX toY paths (queue : PriorityQueue<int * int, int>) (grid : int[][]) =
    let newDistance = grid[toY][toX] + match Map.tryFind (x, y) paths with | Some r1 -> r1 | None -> 0
    match Map.tryFind (toX, toY) paths with
    | Some risk -> if newDistance < risk then queue.Enqueue((toX, toY), newDistance); (toX, toY), newDistance else (toX, toY), risk
    | None -> queue.Enqueue((toX, toY), newDistance); (toX, toY), newDistance

let updatePaths x y endX endY paths (queue : PriorityQueue<int * int, int>) grid =
    [(x - 1, y);(x + 1, y);(x, y - 1);(x, y + 1)]
        |> List.filter (fun (x1, y1) -> isOnGrid x1 y1 endX endY)
        |> List.map (fun (x1, y1) -> getMinPath x y x1 y1 paths queue grid)
        |> List.fold (fun statePaths (p, risk) -> Map.add p risk statePaths) paths
        |> Map.remove (x, y)

let rec findPaths x y endX endY paths queue grid =
    if y = endY && x = endX
    then paths
    else
        let newPaths = updatePaths x y endX endY paths queue grid
        let (nextX, nextY) = queue.Dequeue()
        findPaths nextX nextY endX endY newPaths queue grid

let findShortestPath grid =
    let endX = (Array.length (Array.head grid) - 1)
    let endY = (Array.length grid - 1)
    findPaths 0 0 endX endY Map.empty<int * int, int> (PriorityQueue<int * int, int>()) grid
        |> Map.find (endX, endY)

let solver =
    File.ReadLines "Inputs\\day15.txt"
        |> Seq.map (fun line -> line |> Seq.map (fun x -> (int x - int '0')) |> Seq.toArray)
        |> Seq.toArray
        |> findShortestPath
        |> printfn "%d"