module StringMap = Map.Make(String)

let parse_orbit line = 
  let split_string = String.split_on_char ')' line
  in (List.nth split_string 0, List.nth split_string 1)

let rec count_orbits_single orbit_map (parent, _) count =
  if parent = "COM" then count + 1
  else count_orbits_single orbit_map ((StringMap.find parent orbit_map), parent) (count + 1)

let count_orbits orbits orbit_map =
  List.fold_left (fun count orbit -> count + (count_orbits_single orbit_map orbit 0)) 0 orbits

let () =
  let orbits = Core.In_channel.read_lines "input"
    |> List.map parse_orbit
  in 
    List.fold_left
      (fun orbit_map (parent, child) -> StringMap.add child parent orbit_map)
      StringMap.empty
      orbits
    |> count_orbits orbits
    |> print_int; print_newline()