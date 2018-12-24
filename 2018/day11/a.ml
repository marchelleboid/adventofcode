open Core

let power_level x y =
  let rack_id = x + 10 in
    abs(((rack_id * y + 6303) * rack_id) / 100 mod 10) - 5

let initial_grid = Bigarray.Array2.create Bigarray.int8_signed Bigarray.c_layout 301 301

let fill_power_level_grid =
  let grid = initial_grid in
    for x = 1 to 300 do
      for y = 1 to 300 do
        grid.{x, y} <- (power_level x y)
      done
    done;
    grid

let find_biggest_square grid =
  let max_power = ref (Int.min_value, (0,0)) in
    for x = 1 to 298 do
      for y = 1 to 298 do
        let total_power = grid.{x, y} + grid.{x + 1, y} + grid.{x + 2, y} +
          grid.{x, y + 1} + grid.{x + 1, y + 1} + grid.{x + 2, y + 1} +
          grid.{x, y + 2} + grid.{x + 1, y + 2} + grid.{x + 2, y + 2} in
          if total_power > (fst !max_power) then
            max_power := (total_power, (x, y));
      done
    done;
    snd !max_power

let () =
  let corner = fill_power_level_grid |> find_biggest_square in
    printf "%d,%d\n" (fst corner) (snd corner)
