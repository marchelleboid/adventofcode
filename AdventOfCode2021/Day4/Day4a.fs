module Day4a

open System.IO

type Board = {rows: (int * bool) list list; columns: (int * bool) list list}

let fillColumns row columns =
    match columns with
    | [] -> List.map (fun x -> [x, false]) row
    | _ -> List.mapi (fun i x -> x @ [List.item i row, false]) columns

let toBoard grid =
    grid
        |> Array.map (fun (row : string) -> row.Split(" ", System.StringSplitOptions.RemoveEmptyEntries) |> Array.map int |> Array.toList)
        |> Array.fold (fun board row -> {rows = board.rows @ [List.map (fun r -> r, false) row]; columns = fillColumns row board.columns}) {rows = []; columns = []}

let hasFullRowOrColumn rc =
    rc |> List.exists (fun row -> List.forall (fun x -> snd x) row)

let isAWinner board =
    hasFullRowOrColumn board.rows || hasFullRowOrColumn board.columns

let sumUnmarked board =
    List.sumBy (fun row -> List.sumBy (fun x -> if not (snd x) then fst x else 0) row) board.rows

let updateRowOrColumn draw rc =
    rc |> List.map (fun x -> if draw = fst x then fst x, true else x)

let updateBoard draw board =
    {rows = List.map (fun row -> updateRowOrColumn draw row) board.rows;
     columns = List.map (fun column -> updateRowOrColumn draw column) board.columns}

let rec playBingo (draws : int[]) lastDraw boards =
    match Seq.tryFind isAWinner boards with
    | Some board -> (sumUnmarked board) * lastDraw
    | None -> 
        boards
            |> Seq.map (fun board -> updateBoard draws.[0] board)
            |> playBingo (Array.skip 1 draws) draws.[0]

let solver =
    let lines = File.ReadLines "Inputs\\day4.txt"
    let draws = Seq.item 0 lines |> (fun line -> line.Split(",")) |> Array.map int
    Seq.skip 2 lines
        |> Seq.chunkBySize 6
        |> Seq.map (fun board -> Array.take 5 board)
        |> Seq.map toBoard
        |> playBingo draws 0
        |> printfn "%d"