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

let special_take list ~amount = List.take list amount

let rec find_path dependencies workers second =
  let finished_steps = Map.filter workers ~f:(fun x -> x = second) |> Map.keys in
    let updated_dependencies =
        List.fold ~init:dependencies ~f:update_dependencies finished_steps
      in match Map.is_empty updated_dependencies with 
        | true -> second
        | false ->
          let cleaned_workers = Map.filter workers ~f:(fun x -> x <> second) in
            let ready_tasks = Map.filter updated_dependencies ~f:List.is_empty
              |> Map.keys
              |> List.filter ~f:(fun x -> not (Map.mem cleaned_workers x))
              |> List.sort ~compare:Char.compare
              |> special_take ~amount:(5 - (Map.length cleaned_workers))
            in match ready_tasks with
            | [] -> find_path updated_dependencies cleaned_workers (second + 1)
            | _ ->
              let tasked_workers = List.fold ready_tasks ~init:cleaned_workers ~f:(fun accum task ->
                Map.set accum ~key:task ~data:(second + (Char.to_int task) - 4))
              in find_path updated_dependencies tasked_workers (second + 1)

let () =
  let dependencies = List.map ~f:parse_instruction (In_channel.read_lines "input")
    |> List.fold ~init:Char.Map.empty ~f:build_dependencies
  in find_path dependencies Char.Map.empty 0
      |> printf "%d\n"
