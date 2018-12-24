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

let is_possible_message points =
  let min_y = List.fold points ~init:Int.max_value
    ~f:(fun accum {y; _} -> if y < accum then y else accum) in
    let max_y = List.fold points ~init:0
      ~f:(fun accum {y; _} -> if y > accum then y else accum) in
      (max_y - min_y) < 10

let rec find_message points =
  if is_possible_message points then
    points
  else
    find_message (advance points ~seconds:1)

let get_min list = List.fold list ~init:Int.max_value ~f:min
let get_max list = List.fold list ~init:Int.min_value ~f:max

let draw_grid points =
  let x_points = List.map points ~f:(fun {x; _} -> x) in
    let y_points = List.map points ~f:(fun {y; _} -> y) in
      let min_x = get_min x_points in
        let max_x = get_max x_points in
          let min_y = get_min y_points in
            let max_y = get_max y_points in
              for j = min_y to max_y do
                for i = min_x to max_x do
                  match List.find points ~f:(fun {x; y; _} -> x = i && y = j) with
                  | None -> printf "."
                  | Some(_) -> printf "#"
                done;
                printf "\n";
              done

let () =
  List.map ~f:parse_line (In_channel.read_lines "input")
    |> advance ~seconds:10000
    |> find_message
    |> draw_grid
