module Day16a

open System
open System.IO

let toInt index length (transmission : char[]) =
    transmission[index..index + length - 1]
        |> System.String
        |> (fun s -> Convert.ToInt32(s, 2))

let rec getIndexAfterLiteral startIndex (transmission : char[]) =
    match transmission[startIndex] with
    | '0' -> startIndex + 5
    | _ -> getIndexAfterLiteral (startIndex + 5) transmission

let rec getVersions startIndex versionSum (transmission : char[]) =
    let version = toInt startIndex 3 transmission
    let packetType = toInt (startIndex + 3) 3 transmission
    match packetType with
    | 4 -> versionSum + version, getIndexAfterLiteral (startIndex + 6) transmission
    | _ -> 
        match transmission[startIndex + 6] with
        | '0' -> parseLengthPayload (startIndex + 22) (toInt (startIndex + 7) 15 transmission) (versionSum + version) transmission
        | _ -> parseCountPayload (startIndex + 18) (toInt (startIndex + 7) 11 transmission) (versionSum + version) transmission

and parseLengthPayload startIndex lengthToGo versionSum transmission =
    match lengthToGo with
    | 0 -> versionSum, startIndex
    | _ ->
        let newVersionSum, nextIndex = getVersions startIndex versionSum transmission
        parseLengthPayload nextIndex (lengthToGo - (nextIndex - startIndex)) newVersionSum transmission

and parseCountPayload startIndex countToGo versionSum transmission =
    match countToGo with
    | 0 -> versionSum, startIndex
    | _ ->
        let newVersionSum, nextIndex = getVersions startIndex versionSum transmission
        parseCountPayload nextIndex (countToGo - 1) newVersionSum transmission

let solver =
    File.ReadLines "Inputs\\day16.txt"
        |> Seq.exactlyOne
        |> Seq.map string
        |> Seq.map (fun c -> (Convert.ToString(Convert.ToInt32(c, 16), 2)).PadLeft(4, '0'))
        |> Seq.fold (fun state str -> state + str) ""
        |> Seq.toArray
        |> getVersions 0 0
        |> fst
        |> printfn "%d"