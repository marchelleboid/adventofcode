module Day3b

open System.IO

let findSumAtPosition lines position =
    List.fold (fun sum line -> sum + (List.item position line)) 0 lines

let filterLines lines position sum most =
    List.filter 
        (fun line ->
            if most 
            then
                if (sum >= (List.length lines + 1)/2) 
                then ((List.item position line) = 1) 
                else ((List.item position line) = 0)
            else
                if (sum >= (List.length lines + 1)/2) 
                then ((List.item position line) = 0) 
                else ((List.item position line) = 1))
        lines

let rec findRating position most lines =
    match lines with 
    | [x] -> 
        x 
            |> List.map (fun c -> if c = 0 then '0' else '1') 
            |> List.toArray
            |> System.String
            |> fun rating -> System.Convert.ToInt32(rating, 2)
    | _ ->
        let sum = findSumAtPosition lines position
        findRating (position + 1) most (filterLines lines position sum most)

let solver =
    let lines = 
        File.ReadLines "Inputs\\day3.txt"
            |> Seq.map (fun line -> Seq.map (fun c -> int c - int '0') line |> Seq.toList)
            |> Seq.toList
    let oxygen = 
        lines
            |> findRating 0 true
    let co =
        lines
            |> findRating 0 false
    printfn "%d" (oxygen * co)
