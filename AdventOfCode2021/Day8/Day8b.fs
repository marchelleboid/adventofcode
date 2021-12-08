module Day8b

open System.IO
open System.Linq

type SignalMapping = {top: char; upperLeft: char; upperRight: char; middle: char; lowerLeft: char; lowerRight: char; bottom: char}

let findTop one (seven : string) signals =
    seven.Except(one)
        |> Seq.head
        |> fun h -> {signals with top = h}

let findUpperLeftAndMiddle (four : string) one fiveChars signals =
    let opt1, opt2 = four.Except(one) |> fun s -> Seq.head s, Seq.skip 1 s |> Seq.head
    if Seq.forall (fun s -> Seq.contains opt1 s) fiveChars
    then {signals with middle = opt1; upperLeft = opt2}
    else {signals with middle = opt2; upperLeft = opt1}

let findLowerRightAndUpperRight one sixChars signals =
    let opt1, opt2 = one |> fun s -> Seq.head s, Seq.skip 1 s |> Seq.head
    if Seq.forall (fun s -> Seq.contains opt1 s) sixChars
    then {signals with lowerRight = opt1; upperRight = opt2}
    else {signals with lowerRight = opt2; upperRight = opt1}

let findBottomAndLowerLeft fiveChars signals =
    let opt1, opt2 = 
        "abcdefg".Except([|signals.top;signals.upperLeft;signals.upperRight;signals.middle;signals.lowerLeft;signals.lowerRight|])
        |> fun s -> Seq.head s, Seq.skip 1 s |> Seq.head
    if Seq.forall (fun s -> Seq.contains opt1 s) fiveChars
    then {signals with bottom = opt1; lowerLeft = opt2}
    else {signals with bottom = opt2; lowerLeft = opt1}

let toIntMapping signals =
    Map.empty<string, char>
        |> Map.add ([|signals.top;signals.upperLeft;signals.upperRight;signals.lowerLeft;signals.lowerRight;signals.bottom|] |> Array.sort |> System.String) '0'
        |> Map.add ([|signals.top;signals.upperRight;signals.middle;signals.lowerLeft;signals.bottom|] |> Array.sort |> System.String) '2'
        |> Map.add ([|signals.top;signals.upperRight;signals.middle;signals.lowerRight;signals.bottom|] |> Array.sort |> System.String) '3'
        |> Map.add ([|signals.top;signals.upperLeft;signals.middle;signals.lowerRight;signals.bottom|] |> Array.sort |> System.String) '5'
        |> Map.add ([|signals.top;signals.upperLeft;signals.middle;signals.lowerLeft;signals.lowerRight;signals.bottom|] |> Array.sort |> System.String) '6'
        |> Map.add ([|signals.top;signals.upperLeft;signals.upperRight;signals.middle;signals.lowerRight;signals.bottom|] |> Array.sort |> System.String) '9'

let findSignalMapping inputs = 
    {top = ' '; upperLeft = ' '; upperRight = ' '; middle = ' '; lowerLeft = ' '; lowerRight = ' '; bottom = ' '} 
        |> findTop (Seq.find (fun x -> String.length x = 2) inputs) (Seq.find (fun x -> String.length x = 3) inputs) 
        |> findUpperLeftAndMiddle (Seq.find (fun x -> String.length x = 4) inputs) (Seq.find (fun x -> String.length x = 2) inputs) (Seq.filter (fun x -> String.length x = 5) inputs) 
        |> findLowerRightAndUpperRight (Seq.find (fun x -> String.length x = 2) inputs) (Seq.filter (fun x -> String.length x = 6) inputs)
        |> findBottomAndLowerLeft (Seq.filter (fun x -> String.length x = 5) inputs) 
        |> toIntMapping

let findOutput signalToInt outputStrings =
    outputStrings
        |> Array.map (fun o ->
            match String.length o with 
            | 2 -> '1'
            | 4 -> '4'
            | 3 -> '7'
            | 7 -> '8'
            | _ -> o |> Seq.sort |> System.String.Concat |> (fun k -> Map.find k signalToInt)
        )
        |> System.String
        |> int

let solver =
    let lines = File.ReadLines "Inputs\\day8.txt"
    lines
        |> Seq.map (fun x -> x.Split(" | "))
        |> Seq.map (fun x -> Array.map (fun (y : string) -> y.Split(" ")) x)
        |> Seq.map (fun x -> Seq.head x, Seq.skip 1 x |> Seq.head)
        |> Seq.map (fun (x, y) -> findSignalMapping x, y)
        |> Seq.map (fun (x, y) -> findOutput x y)
        |> Seq.sum
        |> printfn "%d"
       