module Day7a

open System.IO
open System.Collections.Generic

let parseLine (line : string) =
    let split = line.Split(" bags contain ")
    split.[0], (
        if split.[1].StartsWith("no") then Set.empty
        else
            split.[1].Split(", ") 
                |> Array.map (fun x -> x.Split(" ")) 
                |> Array.map (fun x -> x.[1] + " " + x.[2])
                |> Set.ofArray
    )

let fillMapping (d : Dictionary<string, Set<string>>) (bag, bags) =
    d.Add(bag, bags); d

let rec countBags bagType bags (d : Dictionary<string, Set<string>>) = 
    d.Keys
        |> Seq.fold 
            (fun b key -> 
                if Set.contains bagType d.[key] then 
                    let newBags = Set.add key b
                    countBags key newBags d
                else b) 
            bags

let solver =
    File.ReadLines "Inputs\\day7.txt"
        |> Seq.map parseLine
        |> Seq.fold fillMapping (new Dictionary<string, Set<string>>())
        |> countBags "shiny gold" Set.empty
        |> Set.count
        |> printfn "%d"
