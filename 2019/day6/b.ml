module StringMap = Map.Make(String)

let rec find_path_difference list1 list2 position =
  if not (String.equal (List.hd list1) (List.hd list2)) then position
  else find_path_difference (List.tl list1) (List.tl list2) (position + 1)

let parse_orbit line = 
  let split_string = String.split_on_char ')' line
  in (List.nth split_string 0, List.nth split_string 1)

let rec build_orbit_list orbit_map position lst =
  if position = "COM" then lst
  else let parent = (StringMap.find position orbit_map) in
    build_orbit_list orbit_map parent (parent :: lst)

let () =
  let orbit_map = Core.In_channel.read_lines "input"
    |> List.map parse_orbit
    |> List.fold_left
        (fun orbit_map (parent, child) -> StringMap.add child parent orbit_map)
        StringMap.empty
  in
    let you_list = build_orbit_list orbit_map "YOU" [] in
      let san_list = build_orbit_list orbit_map "SAN" [] in
        let difference_position = find_path_difference you_list san_list 0 in
          (List.length you_list - difference_position) + (List.length san_list - difference_position)
          |> print_int; print_newline()