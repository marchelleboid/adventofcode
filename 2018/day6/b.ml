open Core

let parse_line line = Scanf.sscanf line "%d, %d" (fun x y -> (x, y))

let list_max list =
  List.fold ~init:0 ~f:(fun accum x -> if x > accum then x else accum) list

let list_min list =
  List.fold ~init:Int.max_value ~f:(fun accum x -> if x < accum then x else accum) list

let find_extremes points =
  let x_list = List.map ~f:fst points in
    let y_list = List.map ~f:snd points in
      (list_min x_list, list_max x_list, list_min y_list, list_max y_list)

let manhattan_distance (point_x, point_y) x y =
  abs (point_x - x) + abs (point_y - y)

let sum_of_distances points x y =
  List.map ~f:(fun point -> manhattan_distance point x y) points
    |> List.fold ~init:0 ~f:(+)

let locations_within_10000 points min_x max_x min_y max_y =
  let count = ref 0 in
    for i = min_x - 30 to max_x + 30 do
      for j = min_y - 30 to max_y + 30 do
        match sum_of_distances points i j with
        | x when x < 10000 -> count := !count + 1
        | _ -> ()
      done
    done;
    !count

let () =
  let points = List.map ~f:parse_line (In_channel.read_lines "input") in
    let min_x, max_x, min_y, max_y = find_extremes points in
      locations_within_10000 points min_x max_x min_y max_y
        |> printf "%d\n"
