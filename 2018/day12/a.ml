open Core

let initial_state = String.to_array ("...................." ^ "#...#..###.#.###.####.####.#..#.##..#..##..#.....#.#.#.##.#...###.#..##..#.##..###..#..##.#..##..." ^ "....................")

let parse_line line = Scanf.sscanf line "%s => %c" (fun pattern result -> (pattern, result))

let rec grow_plants state instructions count =
  match count with
  | 20 -> state
  | _ ->
    let new_state = Array.copy state in
      for i = 2 to 135 do
        let slice = Array.slice state (i - 2) (i + 3) |> Array.to_list |> String.of_char_list in
          if Set.mem instructions slice then new_state.(i) <- '#' else new_state.(i) <- '.'
      done;
      grow_plants new_state instructions (count + 1)

let () =
  let instructions = In_channel.read_lines "inputa"
    |> List.map ~f:parse_line
    |> List.filter ~f:(fun line -> (snd line) = '#')
    |> List.map ~f:fst
    |> String.Set.of_list in
    grow_plants initial_state instructions 0
      |> Array.foldi ~init:0 ~f:(fun i accum c -> if c = '#' then accum + i - 20 else accum)
      |> printf "%d\n"
