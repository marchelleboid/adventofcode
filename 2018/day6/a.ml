open Core

module Point = struct
  module T = struct
    type t = int * int
    let compare x y = let fst_compare = fst x - fst y in
      if fst_compare <> 0 then fst_compare
      else snd x - snd y
    let sexp_of_t t = Tuple2.sexp_of_t Int.sexp_of_t Int.sexp_of_t t
    end
  include T
  include Comparator.Make(T)
end

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
  ((point_x, point_y), abs (point_x - x) + abs (point_y - y))

let find_closest_point points x y =
  let sorted_distances = List.map ~f:(fun point -> manhattan_distance point x y) points
    |> List.sort ~compare:(fun a b -> snd a - snd b)
    in
      match sorted_distances with
      | [] -> (-1, -1)
      | [hd] -> fst hd
      | hd_1 :: hd_2 :: _ when snd hd_1 = snd hd_2 -> (-1, -1)
      | hd :: _ -> fst hd

let closest_points_map points min_x max_x min_y max_y =
  let min_distance_tally = ref (Map.empty(module Point)) in
    for i = min_x - 30 to max_x + 30 do
      for j = min_y - 30 to max_y + 30 do
        match find_closest_point points i j with
        | (-1, -1) -> ()
        | point -> min_distance_tally :=
          match Map.find !min_distance_tally point with
          | None -> Map.set !min_distance_tally ~key:point ~data:1
          | Some(x) ->  Map.set !min_distance_tally ~key:point ~data:(x + 1)
      done
    done;
    !min_distance_tally

let infinite_points points min_x max_x min_y max_y =
  let infinite_points_set = ref (Set.empty(module Point)) in
    for x = min_x - 30 to max_x + 30 do
      match find_closest_point points x (min_y - 30) with
        | (-1, -1) -> ()
        | point -> infinite_points_set := Set.add !infinite_points_set point
    done;
    for x = min_x - 30 to max_x + 30 do
      match find_closest_point points x (max_y + 30) with
        | (-1, -1) -> ()
        | point -> infinite_points_set := Set.add !infinite_points_set point
    done;
    for y = min_y - 30 to max_y + 30 do
      match find_closest_point points (min_x - 30) y with
        | (-1, -1) -> ()
        | point -> infinite_points_set := Set.add !infinite_points_set point
    done;
    for y = min_y - 30 to max_y + 30 do
      match find_closest_point points (max_x + 30) y with
        | (-1, -1) -> ()
        | point -> infinite_points_set := Set.add !infinite_points_set point
    done;
    !infinite_points_set

let () =
  let points = List.map ~f:parse_line (In_channel.read_lines "input") in
    let min_x, max_x, min_y, max_y = find_extremes points in
      let closest_points = closest_points_map points min_x max_x min_y max_y in
        let infinite_points_set = infinite_points points min_x max_x min_y max_y in
          Map.filter_keys closest_points ~f:(fun k -> not (Set.mem infinite_points_set k))
            |> Map.fold ~init:0 ~f:(fun ~key:_ ~data accum -> if data > accum then data else accum)
            |> printf "%d\n"
