open Core

let rec has_doubles_and_triples string_list single_set double_set triple_set many_set =
  match string_list with
  | [] ->
    let has_double = if Set.is_empty double_set then 0 else 1 in
      let has_triple = if Set.is_empty triple_set then 0 else 1 in
        (has_double, has_triple)
  | hd :: tl when Set.mem single_set hd ->
    has_doubles_and_triples tl (Set.remove single_set hd) (Set.add double_set hd) triple_set many_set
  | hd :: tl when Set.mem double_set hd ->
    has_doubles_and_triples tl single_set (Set.remove double_set hd) (Set.add triple_set hd) many_set
  | hd :: tl when Set.mem triple_set hd ->
    has_doubles_and_triples tl single_set double_set (Set.remove triple_set hd) (Set.add many_set hd)
  | hd :: tl when Set.mem many_set hd ->
    has_doubles_and_triples tl single_set double_set triple_set many_set
  | hd :: tl ->
    has_doubles_and_triples tl (Set.add single_set hd) double_set triple_set many_set

let multiply_tuple (x0, x1) = x0 * x1

let () =
  In_channel.read_lines "input"
    |> List.map ~f:(fun x -> has_doubles_and_triples (String.to_list x) Char.Set.empty Char.Set.empty Char.Set.empty Char.Set.empty)
    |> List.fold ~init:(0,0) ~f:(fun accum x -> 
       let (a0, a1) = accum in
         let (x0, x1) = x in
           (a0 + x0, a1 + x1))
    |> multiply_tuple
    |> printf "%d\n"