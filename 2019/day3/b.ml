module Point = struct
  type t = int * int * int
  let compare (x0,y0,_) (x1,y1,_) =
    match Stdlib.compare x0 x1 with
      | 0 -> Stdlib.compare y0 y1
      | c -> c
end

module PointSet = Set.Make(Point)

let parse_command command = Scanf.sscanf command "%c%d" (fun x y -> (x, y))

let parse_wire line = 
  String.split_on_char ',' line
    |> List.map parse_command

let update_position_time direction x y counter =
  match direction with
  | 'L' -> (x - 1, y, counter + 1)
  | 'R' -> (x + 1, y, counter + 1)
  | 'U' -> (x, y + 1, counter + 1)
  | 'D' -> (x, y - 1, counter + 1)
  | _ -> (x, y, counter)

let rec update_visited direction count x y counter visited =
  if count = 0 then visited
  else
    let (new_x, new_y, new_counter) = update_position_time direction x y counter
    in
      update_visited direction (count - 1) new_x new_y new_counter (PointSet.add (new_x, new_y, new_counter) visited)

let handle_command state command =
  let (visited, (current_x, current_y, counter)) = state in
    match command with
    | ('L', i) -> (update_visited 'L' i current_x current_y counter visited, (current_x - i, current_y, counter + i))
    | ('R', i) -> (update_visited 'R' i current_x current_y counter visited, (current_x + i, current_y, counter + i))
    | ('U', i) -> (update_visited 'U' i current_x current_y counter visited, (current_x, current_y + i, counter + i))
    | ('D', i) -> (update_visited 'D' i current_x current_y counter visited, (current_x, current_y - i, counter + i))
    | _ -> state

let wire_visited first_wire =
  let result = List.fold_left handle_command (PointSet.empty, (0, 0, 0)) first_wire in
    fst result

let rec update_min direction count x y counter visited current_min =
  if count = 0 then current_min
  else
    let (new_x, new_y, new_counter) = update_position_time direction x y counter
    in
      let new_min = 
      if PointSet.mem (new_x, new_y, 0) visited then
        let _, _, first_counter = PointSet.find (new_x, new_y, 0) visited in
          let total_time = first_counter + new_counter in
            min total_time current_min
      else current_min
      in
        update_min direction (count - 1) new_x new_y new_counter visited new_min

let handle_command_2 state command =
  let (current_min, (current_x, current_y, counter), visited) = state in
    match command with
    | ('L', i) -> (update_min 'L' i current_x current_y counter visited current_min, (current_x - i, current_y, counter + i), visited)
    | ('R', i) -> (update_min 'R' i current_x current_y counter visited current_min, (current_x + i, current_y, counter + i), visited)
    | ('U', i) -> (update_min 'U' i current_x current_y counter visited current_min, (current_x, current_y + i, counter + i), visited)
    | ('D', i) -> (update_min 'D' i current_x current_y counter visited current_min, (current_x, current_y - i, counter + i), visited)
    | _ -> state

let get_intersections first_wire_visited second_wire =
  let result, _, _ = List.fold_left handle_command_2 (1000000, (0, 0, 0), first_wire_visited) second_wire in
    result

let () =
  let in_channel = open_in "input" in
    let first_wire_visited = input_line in_channel
      |> parse_wire
      |> wire_visited
    in
      input_line in_channel
        |> parse_wire
        |> get_intersections first_wire_visited
        |> print_int; print_newline()