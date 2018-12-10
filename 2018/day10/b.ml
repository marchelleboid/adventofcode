open Core

type point = { x: int; y: int; v_x: int; v_y: int }

let remove_spaces line =
  String.filter line ~f:(fun char -> char <> ' ')

let parse_line line =
  Scanf.sscanf (remove_spaces line) "position=<%d,%d>velocity=<%d,%d>"
    (fun x y v_x v_y -> { x; y; v_x; v_y })

let advance points ~seconds =
  List.map points ~f:(fun { x; y; v_x; v_y } ->
    { x = x + v_x * seconds; y = y + v_y * seconds; v_x; v_y })

let insert_or_increment y_map {y; _} =
  let count = match Map.find y_map y with
  | None -> 1
  | Some(count) -> count + 1
  in Map.set y_map ~key:y ~data:count

let is_possible_message points =
  (* let y_map = List.fold points ~init:Int.Map.empty ~f:insert_or_increment in *)
    let min_y = List.fold points ~init:Int.max_value
      ~f:(fun accum {y; _} -> if y < accum then y else accum) in
      let max_y = List.fold points ~init:0
        ~f:(fun accum {y; _} -> if y > accum then y else accum) in
        (max_y - min_y) < 10
    (* Map.is_empty (Map.filter x_map ~f:(fun count -> count = 8)) *)

let rec find_message_wait_time points ~seconds =
  if is_possible_message points then
    seconds
  else
    find_message_wait_time (advance points ~seconds:1) ~seconds:(seconds + 1)

let () =
  List.map ~f:parse_line (In_channel.read_lines "input")
    |> advance ~seconds:10000
    |> find_message_wait_time ~seconds:10000
    |> printf "%d\n"
