open Core

let rec react_helper input output changes_made =
  match input with
  | [] -> (output, changes_made)
  | [x] -> (x :: output, changes_made)
  | hd :: sn :: (_ as tl) when (hd <> sn && Char.lowercase hd = Char.lowercase sn) ->
    react_helper tl output true
  | hd :: (_ as tl) ->
    react_helper tl (hd :: output) changes_made

let rec react input =
  match react_helper input [] false with
  | (output, false) -> output
  | (output, true) -> react output

let () =
  String.strip (In_channel.read_all "input")
    |> String.to_list
    |> react
    |> List.length
    |> printf "%d\n"
