module Day18b

open System.IO

let printSF sf =
    Array.fold (fun state c -> state + c) "" sf |> printfn "%s"

let splitInt x =
    if x % 2 = 0
    then [|"["; string (x / 2); ","; string (x / 2);"]"|]
    else [|"["; string (x / 2); ","; string (x / 2 + 1);"]"|]

let explode (snailFish : string[]) =
    let mutable depth = 0
    let mutable lastNumberIndex = 0
    let mutable explodeIndex = 0
    let mutable explodeEndIndex = 0
    let mutable nextNumberIndex = 0
    let mutable i = 0
    while nextNumberIndex = 0 && i <> Array.length snailFish do
        match snailFish[i] with
        | "[" -> 
            if explodeIndex = 0 && depth = 4
            then explodeIndex <- i
            else depth <- depth + 1
        | "]" -> 
            if explodeIndex = 0
            then depth <- depth - 1
            else if explodeEndIndex = 0
            then explodeEndIndex <- i
        | "," -> ()
        | _ ->
            if explodeIndex = 0
            then lastNumberIndex <- i
            else if explodeEndIndex <> 0
            then nextNumberIndex <- i
        i <- i + 1
    if explodeEndIndex <> 0
    then
        let left, right = int snailFish[explodeIndex + 1], int snailFish[explodeEndIndex - 1]
        if lastNumberIndex <> 0 then snailFish[lastNumberIndex] <- string (int snailFish[lastNumberIndex] + left)
        if nextNumberIndex <> 0 then snailFish[nextNumberIndex] <- string (int snailFish[nextNumberIndex] + right)
        let exploded = Array.concat [ snailFish[0..explodeIndex - 1]; [|"0"|]; snailFish[explodeEndIndex + 1..] ]
        exploded, true
    else [|""|], false

let split (snailFish : string[]) =
    let mutable depth = 0
    let mutable splitIndex = 0
    let mutable i = 0
    while splitIndex = 0 && i <> Array.length snailFish do
        match snailFish[i] with
        | "[" | "]" | "," -> ()
        | x ->
            if int x > 9
            then splitIndex <- i
        i <- i + 1
    if splitIndex <> 0
    then
        let splitResult = int snailFish[splitIndex] |> splitInt
        let split = Array.concat [ snailFish[0..splitIndex - 1]; splitResult; snailFish[splitIndex + 1..] ]
        split, true
    else [|""|], false

let rec reduce snailFish =
    let result, didExplode = explode snailFish
    if didExplode
    then reduce result
    else
        let result, didSplit = split snailFish
        if didSplit
        then reduce result
        else snailFish

let rec magnitude (snailFish : string[]) =
    if Array.length snailFish = 1
    then
        snailFish
            |> Array.exactlyOne
            |> int 
    else
        let mutable i = 0
        let mutable foundPairIndex = 0
        while foundPairIndex = 0 && i <> Array.length snailFish do
            if snailFish[i] = "[" && snailFish[i + 4] = "]"
            then foundPairIndex <- i
            i <- i + 1
        let newValue = ((int snailFish[foundPairIndex + 1]) * 3) + ((int snailFish[foundPairIndex + 3]) * 2)
        if foundPairIndex = 0
        then
            magnitude [|string newValue|]
        else
            magnitude (Array.concat [ snailFish[0..foundPairIndex - 1]; [|string newValue|]; snailFish[foundPairIndex + 5..] ])

let solver =
    let lines = File.ReadLines "Inputs\\day18.txt" |> Seq.map Seq.toArray |> Seq.map (fun l -> Array.map (fun c-> System.String [|c|]) l) |> Seq.toList
    let mutable maxMag = 0
    for i in 0..(List.length lines - 2) do
        for j in i + 1..(List.length lines - 1) do
            let thisMag = reduce (Array.concat [ [|"["|]; (List.item i lines); [|","|]; (List.item j lines); [|"]"|] ]) |> magnitude
            maxMag <- max maxMag thisMag
            let thisMag = reduce (Array.concat [ [|"["|]; (List.item j lines); [|","|]; (List.item i lines); [|"]"|] ]) |> magnitude
            maxMag <- max maxMag thisMag
    printfn "%d" maxMag