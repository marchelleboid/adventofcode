module Day7b

open System.IO
open System.Collections.Generic

let parseLine (line : string) =
    let split = line.Split(" bags contain ")
    split.[0], (
        if split.[1].StartsWith("no") then Set.empty
        else
            split.[1].Split(", ") 
                |> Array.map (fun x -> x.Split(" ")) 
                |> Array.map (fun x -> x.[0] + " " + x.[1] + " " + x.[2])
                |> Set.ofArray
    )

let fillMapping (d : Dictionary<string, Set<string>>) (bag, bags) =
    d.Add(bag, bags); d

let getParts (innerBag : string) =
    let splits = innerBag.Split(" ")
    int splits.[0], splits.[1] + " " + splits.[2]

let rec countBags bagType (d : Dictionary<string, Set<string>>) = 
    d.[bagType]
        |> Set.toSeq
        |> Seq.sumBy 
            (
                fun x ->
                let (num, bag) = getParts x
                num + num * (countBags bag d)
            )

let solver =
    File.ReadLines "Inputs\\day7.txt"
        |> Seq.map parseLine
        |> Seq.fold fillMapping (new Dictionary<string, Set<string>>())
        |> countBags "shiny gold"
        |> printfn "%d"
