open Core

let parse_instruction line =
  Scanf.sscanf line "Step %c must be finished before step %c can begin." (fun x y -> (y, x))

let build_dependencies accum instruction =
  let step, prior_step = instruction in
    let map_with_prior_step =
      match Map.find accum prior_step with
      | None -> Map.set accum ~key:prior_step ~data:[]
      | Some(_) -> accum
    in
      match Map.find map_with_prior_step step with
      | None -> Map.set map_with_prior_step ~key:step ~data:[prior_step]
      | Some(dependencies) -> Map.set map_with_prior_step ~key:step ~data:(prior_step :: dependencies)

let update_dependencies dependencies next_step =
  Map.remove dependencies next_step
    |> Map.map ~f:(fun deps -> List.filter deps ~f:(fun x -> x <> next_step))

let rec find_path dependencies path =
  match Map.is_empty dependencies with
  | true -> path
  | false ->
    let next_step = Map.fold dependencies ~init:'Z' ~f:(fun ~key ~data accum ->
        match data with
        | [] -> if Char.to_int key < Char.to_int accum then key else accum
        | _ -> accum)
    in
      find_path (update_dependencies dependencies next_step) (next_step :: path) 

let () =
  let dependencies = List.map ~f:parse_instruction (In_channel.read_lines "input")
    |> List.fold ~init:Char.Map.empty ~f:build_dependencies
  in
    find_path dependencies []
      |> List.rev
      |> String.of_char_list
      |> printf "%s\n"
