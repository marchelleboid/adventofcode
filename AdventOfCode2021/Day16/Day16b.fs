module Day16b

open System
open System.IO

let toInt index length (transmission : char[]) =
    transmission[index..index + length - 1]
        |> System.String
        |> (fun s -> Convert.ToInt32(s, 2))

let rec getLiteral startIndex valueSoFar (transmission : char[]) =
    let newValue = transmission[startIndex + 1..startIndex + 4] |> System.String
    match transmission[startIndex] with
    | '0' -> Convert.ToUInt64((valueSoFar + newValue), 2), startIndex + 5
    | _ -> getLiteral (startIndex + 5) (valueSoFar + newValue) transmission

let rec getValue startIndex (transmission : char[]) =
    let packetType = toInt (startIndex + 3) 3 transmission
    match packetType with
    | 4 -> getLiteral (startIndex + 6) "" transmission
    | 0 | 1 | 2 | 3 ->
        let op, initialValue = Array.item packetType [|(+), 0UL; (*), 1UL; min, System.UInt64.MaxValue; max, 0UL|]
        match transmission[startIndex + 6] with
        | '0' -> parseLengthPayload (startIndex + 22) (toInt (startIndex + 7) 15 transmission) op initialValue transmission
        | _ -> parseCountPayload (startIndex + 18) (toInt (startIndex + 7) 11 transmission) op initialValue transmission
    | _ ->
        let op = Array.item (packetType - 5) [|(>); (<); (=)|]
        match transmission[startIndex + 6] with
        | '0' -> parseTwoPacketLengthPayload (startIndex + 22) op transmission
        | _ -> parseTwoPacketLengthPayload (startIndex + 18) op transmission

and parseLengthPayload startIndex lengthToGo op valueSoFar transmission =
    match lengthToGo with
    | 0 -> valueSoFar, startIndex
    | _ ->
        let value, nextIndex = getValue startIndex transmission
        parseLengthPayload nextIndex (lengthToGo - (nextIndex - startIndex)) op (op valueSoFar value) transmission

and parseCountPayload startIndex countToGo op valueSoFar transmission =
    match countToGo with
    | 0 -> valueSoFar, startIndex
    | _ ->
        let value, nextIndex = getValue startIndex transmission
        parseCountPayload nextIndex (countToGo - 1) op (op valueSoFar value) transmission

and parseTwoPacketLengthPayload startIndex op transmission =
    let oneValue, nextIndex = getValue startIndex transmission
    let twoValue, finalIndex = getValue nextIndex transmission
    (if op oneValue twoValue then 1UL else 0UL), finalIndex

let solver =
    File.ReadLines "Inputs\\day16.txt"
        |> Seq.exactlyOne
        |> Seq.map string
        |> Seq.map (fun c -> (Convert.ToString(Convert.ToInt32(c, 16), 2)).PadLeft(4, '0'))
        |> Seq.fold (fun state str -> state + str) ""
        |> Seq.toArray
        |> getValue 0
        |> fst
        |> printfn "%d"