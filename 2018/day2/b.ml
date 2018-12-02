open Core

let rec has_one_difference string_list_1 string_list_2 one_difference_found =
  match string_list_1 with
  | [] -> one_difference_found
  | hd1 :: tl1 ->
    match string_list_2 with
    | [] -> false
    | hd2 :: tl2 when hd1 <> hd2 && not one_difference_found -> has_one_difference tl1 tl2 true
    | hd2 :: _ when hd1 <> hd2 -> false
    | _ :: tl2 -> has_one_difference tl1 tl2 one_difference_found

let rec find_duo_helper string strings =
  match strings with
  | [] -> None
  | hd :: tl ->
    match has_one_difference (String.to_list string) (String.to_list hd) false with
    | true -> Some(string, hd)
    | false -> find_duo_helper string tl

let rec find_duo strings =
  match strings with
  | [] -> ()
  | hd :: tl ->
    match find_duo_helper hd tl with
    | None -> find_duo tl
    | Some(s0, s1) -> printf "%s\n%s\n" s0  s1

let () = find_duo (In_channel.read_lines "input")
