open Core

let rec react_helper input output char_to_remove changes_made =
  match input with
  | [] -> (output, changes_made)
  | [x] -> (x :: output, changes_made)
  | hd :: (_ as tl) when Char.lowercase hd = char_to_remove ->
    react_helper tl output char_to_remove changes_made
  | hd :: sn :: (_ as tl) when (hd <> sn && Char.lowercase hd = Char.lowercase sn) ->
    react_helper tl output char_to_remove true
  | hd :: (_ as tl) ->
    react_helper tl (hd :: output) char_to_remove changes_made

let rec react input char_to_remove =
  match react_helper input [] char_to_remove false with
  | (output, false) -> List.length output
  | (output, true) -> react output char_to_remove

let rec find_smallest_reaction input char_to_remove_as_int smallest_length =
  match char_to_remove_as_int with
  | 123 -> smallest_length
  | c -> find_smallest_reaction input (c + 1) (min smallest_length (react input (Char.of_int_exn c)))

let () =
  let input = String.to_list (String.strip (In_channel.read_all "input")) in
    printf "%d\n" (find_smallest_reaction input 97 11264)
