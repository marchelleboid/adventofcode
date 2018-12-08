open Core

type node =
{
  metadata: int array;
  children: node list;
}

let rec do_n_times f init n =
  match n with
  | 0 -> init
  | _ -> do_n_times f (f (snd init) (fst init)) (n - 1)

let rec parse_tree int_array index accum =
  let number_of_children = int_array.(index) in
    let number_of_metadata = int_array.(index + 1) in
      let children, new_index = do_n_times (parse_tree int_array) ([], index + 2) number_of_children in
        let metadata = Array.slice int_array new_index (new_index + number_of_metadata) in
          let final_index = new_index + number_of_metadata in
            {children = (List.rev children); metadata} :: accum, final_index

let rec node_value node =
  match node.children with
  | [] -> Array.fold node.metadata ~init:0 ~f:(+)
  | _ -> Array.map node.metadata ~f:(
      fun x -> if x <= List.length node.children then node_value (List.nth_exn node.children (x - 1)) else 0)
      |> Array.fold ~init:0 ~f:(+)

let () =
  let ints = String.strip (In_channel.read_all "input")
    |> String.split ~on:' '
    |> List.map ~f:int_of_string
    |> Array.of_list
  in
    parse_tree ints 0 []
      |> fst
      |> List.hd_exn
      |> node_value
      |> printf "%d\n"