module Day3a

open System.IO

let rec add total line =
    match total, line with
    | [], _ -> line
    | _, [] -> []
    | a::atail, b::btail -> (a + b) :: (add atail btail)

let solver =
    let lines = File.ReadLines "Inputs\\day3.txt"
    lines
        |> Seq.map (fun line -> Seq.map (fun c -> int c - int '0') line |> Seq.toList)
        |> Seq.fold add []
        |> List.map (fun sum -> if (sum > (Seq.length lines)/2) then '1' else '0')
        |> List.toArray 
        |> System.String
        |> fun gamma -> System.Convert.ToInt32(gamma, 2) * System.Convert.ToInt32(String.map (fun c -> if (c = '1') then '0' else '1') gamma, 2)
        |> printfn "%d"