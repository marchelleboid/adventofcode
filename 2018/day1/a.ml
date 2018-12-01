open Core

let () =
  In_channel.read_lines "input"
    |> List.map ~f:int_of_string
    |> List.fold ~init:0 ~f:(+)
    |> printf "%d\n"