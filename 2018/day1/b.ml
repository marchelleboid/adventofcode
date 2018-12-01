open Core

type state =
{
  seen: Int.Set.t;
  last: int;
  found: bool;
}

let rec sum_and_store lines state =
  match lines with
  | [] -> state
  | hd :: tl ->
    let next_sum = hd + state.last in
      if Set.mem state.seen next_sum then {seen = Int.Set.empty; last = next_sum; found = true}
      else sum_and_store tl {seen = Set.add state.seen next_sum; last = next_sum; found = false}

let rec sum_until_duplicate lines ~init =
  match sum_and_store lines init with
  | {found = true; last = duplicate; _} -> duplicate
  | state -> sum_until_duplicate lines ~init:state

let () =
  In_channel.read_lines "input"
    |> List.map ~f:int_of_string
    |> sum_until_duplicate ~init:{seen = Int.Set.of_list [0]; last = 0; found = false}
    |> printf "%d\n"