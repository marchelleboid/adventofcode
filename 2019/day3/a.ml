module Point = struct
  type t = int * int
  let compare (x0,y0) (x1,y1) =
    match Stdlib.compare x0 x1 with
      | 0 -> Stdlib.compare y0 y1
      | c -> c
end

module PointSet = Set.Make(Point)

let parse_command command = Scanf.sscanf command "%c%d" (fun x y -> (x, y))

let parse_wire line = 
  String.split_on_char ',' line
    |> List.map parse_command

let rec update_visited direction count x y visited =
  if count = 0 then visited
  else
    let (new_x, new_y) = 
      match direction with
      | 'L' -> (x - 1, y)
      | 'R' -> (x + 1, y)
      | 'U' -> (x, y + 1)
      | 'D' -> (x, y - 1)
      | _ -> (x, y)
    in
      update_visited direction (count - 1) new_x new_y (PointSet.add (new_x, new_y) visited)

let handle_command state command =
  let (visited, (current_x, current_y)) = state in
    match command with
    | ('L', i) -> (update_visited 'L' i current_x current_y visited, (current_x - i, current_y))
    | ('R', i) -> (update_visited 'R' i current_x current_y visited, (current_x + i, current_y))
    | ('U', i) -> (update_visited 'U' i current_x current_y visited, (current_x, current_y + i))
    | ('D', i) -> (update_visited 'D' i current_x current_y visited, (current_x, current_y - i))
    | _ -> state

let wire_visited first_wire =
  let result = List.fold_left handle_command (PointSet.empty, (0, 0)) first_wire in
    fst result

let () =
  let in_channel = open_in "input" in
    let first_wire_visited = input_line in_channel
      |> parse_wire
      |> wire_visited
    in
      let second_wire_visited = input_line in_channel
        |> parse_wire
        |> wire_visited
      in
        let intersection = PointSet.inter first_wire_visited second_wire_visited in
          PointSet.fold
            (fun (x, y) min -> let distance = abs x + abs y in if distance < min then distance else min) 
            intersection
            1000000
          |> print_int; print_newline()
