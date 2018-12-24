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

let find_biggest_square_helper grid size =
  let max_power = ref (Int.min_value, (0,0)) in
    for x = 1 to (301 - size) do
      for y = 1 to (301 - size) do
        let square_power = ref 0 in
        for i = x to x + size - 1 do
          for j = y to y + size - 1 do
            square_power := !square_power + grid.{i, j}
          done
        done;
        if !square_power > (fst !max_power) then
          max_power := (!square_power, (x, y));
      done
    done;
    !max_power

let rec find_biggest_square grid size largest_corner =
  match size with
  | 301 -> snd largest_corner
  | _ ->
    let size_max_power = find_biggest_square_helper grid size in
      if (fst size_max_power) > (fst largest_corner) then
        find_biggest_square grid (size + 1) (fst size_max_power, (fst (snd size_max_power), snd (snd size_max_power), size))
      else
        find_biggest_square grid (size + 1) largest_corner

let () =
  let grid = fill_power_level_grid in
    let corner = find_biggest_square grid 3 (0, (0,0,0)) in
      printf "%d,%d,%d\n" (fst3 corner) (snd3 corner) (trd3 corner)
