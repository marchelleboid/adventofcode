module Day12a

open System
open System.IO

let addConnectionsToMap (line : string) connections =
    let splitLine = line.Split("-")
    connections
        |> Map.change splitLine[0] (fun x -> 
            match x with
            | Some c -> Some (splitLine[1] :: c)
            | None -> Some ([splitLine[1]])
            )
        |> Map.change splitLine[1] (fun x -> 
            match x with
            | Some c -> Some (splitLine[0] :: c)
            | None -> Some ([splitLine[0]])
            )

let rec countPaths p seen connections =
    match p with
    | "start" -> 0
    | "end" -> 1
    | ps when Char.IsLower(ps[0]) && Set.contains ps seen -> 0
    | _ ->
        connections
            |> Map.find p
            |> List.map (fun e -> countPaths e (Set.add p seen) connections)
            |> List.sum

let findPaths connections =
    connections
        |> Map.find "start"
        |> List.map (fun e -> countPaths e Set.empty<string> connections)
        |> List.sum

let solver =
    File.ReadLines "Inputs\\day12.txt"
        |> Seq.fold (fun connections line -> addConnectionsToMap line connections) Map.empty<string, string list>
        |> findPaths
        |> printfn "%d"