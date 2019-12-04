module CharMap = Map.Make(struct
  type t = char
  let compare a b = Stdlib.compare a b
end)

let verify_ascending combined_list =
  List.filter (fun (c1, c2) -> c1 > c2) combined_list
    |> List.length
    |> (=) 0

let verify_groups list =
  List.fold_left 
    (fun counts c -> if CharMap.mem c counts then
      let count = CharMap.find c counts in
        CharMap.add c (count + 1) counts
    else
      CharMap.add c 1 counts
    ) 
    CharMap.empty
    list
    |> CharMap.bindings
    |> List.filter (fun (_, count) -> count = 2)
    |> List.length
    |> (<) 0

let verify number_string =
  let shifted_string = (String.sub number_string 1 (String.length number_string - 1)) ^ "a" in
    let list_1 = List.of_seq (String.to_seq number_string) in
      let list_2 = List.of_seq (String.to_seq shifted_string) in
        let combined_list = List.combine list_1 list_2 in
        (verify_ascending combined_list) && (verify_groups list_1)

let rec count_valid_passwords current stop count =
  if current > stop then count
  else
    let new_count = 
    if verify (Int.to_string current) then count + 1 else count
    in
      count_valid_passwords (current + 1) stop new_count

let () =
  count_valid_passwords 284639 748759 0
    |> print_int; print_newline()
