let split splits character =
  match splits with
  | [] -> [Char.escaped character]
  | hd :: tl -> 
    if String.length hd = 150 then
      Char.escaped character :: hd :: tl
    else
      (hd ^ Char.escaped character) :: tl

let split_layers line =
  String.to_seq line
    |> Seq.fold_left split []

let count_chars layer char =
  String.to_seq layer
    |> Seq.filter (fun c -> if c = char then true else false)
    |> List.of_seq |> List.length

let make_counts layers =
  List.map (fun layer -> (count_chars layer '0', (count_chars layer '1') * (count_chars layer '2'))) layers

let () =
  open_in "input"
    |> input_line
    |> split_layers
    |> make_counts
    |> List.fold_left (fun current_min layer_count -> if fst layer_count < fst current_min then layer_count else current_min) (1000, 0)
    |> snd
    |> print_int; print_newline()