open Core

let () =
  In_channel.read_lines "input"
    |> List.map ~f:int_of_string
    |> List.map ~f:(fun x -> x/3 - 2)
    |> List.fold ~init:0 ~f:(+)
    |> printf "%d\n"