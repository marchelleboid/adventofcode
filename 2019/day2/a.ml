let replace position new_value lst = 
  List.mapi (fun i x -> if i = position then new_value else x) lst

let perform_operation first_position second_position result_position opcode program =
  let first_value = List.nth program first_position in
    let second_value = List.nth program second_position in
      let result = 
        match opcode with
        | 1 -> first_value + second_value
        | 2 -> first_value * second_value
        | _ -> print_string "error 2"; 0
      in
        replace result_position result program

let rec run_program position program =
  let opcode = List.nth program position in
    match opcode with
    | 1 | 2 -> 
      let new_program =
        perform_operation (List.nth program (position + 1)) (List.nth program (position + 2)) (List.nth program (position + 3)) opcode program
      in
        run_program (position + 4) new_program
    | 99 -> program
    | _ -> print_string "error 1"; program

let () =
  open_in "input"
    |> input_line
    |> String.split_on_char ','
    |> List.map int_of_string
    |> replace 1 12
    |> replace 2 2
    |> run_program 0
    |> (Fun.flip List.nth) 0
    |> print_int; print_newline ()