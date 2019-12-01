open Core

let rec calc_fuel mass =
  let fuel = (mass/3 - 2) in
    match fuel with
    | f when f <= 0 -> 0
    | _ -> fuel + (calc_fuel fuel)

let () =
  In_channel.read_lines "input"
    |> List.map ~f:int_of_string
    |> List.map ~f:calc_fuel
    |> List.fold ~init:0 ~f:(+)
    |> printf "%d\n"