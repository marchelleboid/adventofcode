type command = Add | Multiply | Input | Output | Halt

let replace position new_value lst = 
  List.mapi (fun i x -> if i = position then new_value else x) lst

let is_position_param param_number opcode =
  let opcode_list = string_of_int opcode
    |> String.to_seq
    |> List.of_seq
  in
    match List.length opcode_list with
    | 1 | 2 -> true
    | 3 -> if param_number = 2 then true
      else (List.nth opcode_list 0) = '0'
    | 4 -> if param_number = 2 then (List.nth opcode_list 0) = '0'
      else (List.nth opcode_list 1) = '0'
    | _ -> false

let perform_operation first_position second_position result_position opcode command_type program =
  let first_value = if is_position_param 1 opcode then
    List.nth program first_position
  else
    first_position
  in
    let second_value = if is_position_param 2 opcode then
      List.nth program second_position
    else
      second_position
    in
      let result = 
        match command_type with
        | Add -> first_value + second_value
        | Multiply -> first_value * second_value
        | _ -> print_string "error 2"; 0
      in
        replace result_position result program

let parse_opcode opcode =
  let command_number = opcode mod 100 in
  match command_number with
  | 1 -> Add
  | 2 -> Multiply
  | 3 -> Input
  | 4 -> Output
  | 99 -> Halt
  | _ -> print_string "error 1"; Halt

let rec run_program position program =
  let opcode = List.nth program position in
    let command_type = parse_opcode opcode in
      match command_type with
      | Add | Multiply -> 
        let new_program =
          perform_operation (List.nth program (position + 1)) (List.nth program (position + 2)) (List.nth program (position + 3)) opcode command_type program
        in
          run_program (position + 4) new_program
      | Input -> let new_program = replace (List.nth program (position + 1)) 1 program in
        run_program (position + 2) new_program
      | Output -> let output_position = List.nth program (position + 1) in
        List.nth program output_position |> print_int; print_newline();
        run_program (position + 2) program
      | Halt -> program

let () =
  open_in "input"
    |> input_line
    |> String.split_on_char ','
    |> List.map int_of_string
    |> run_program 0
    |> ignore; print_newline ()