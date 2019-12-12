type command = Add | Multiply | Input | Output | Halt | Jump_If_True | Jump_If_False | Less_Than | Equal

type program_state = {
  program : int list;
  position : int;
  inputs : int list;
  outputs : int list;
  halted : bool;
}

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

let get_values_from_parameters first_parameter second_parameter opcode program =
  let first_value = if is_position_param 1 opcode then
    List.nth program first_parameter
  else
    first_parameter
  in
    let second_value = if is_position_param 2 opcode then
      List.nth program second_parameter
    else
      second_parameter
    in
    (first_value, second_value)

let perform_operation first_parameter second_parameter result_position opcode command_type program =
  let first_value, second_value = get_values_from_parameters first_parameter second_parameter opcode program
    in
      let result = 
        match command_type with
        | Add -> first_value + second_value
        | Multiply -> first_value * second_value
        | Less_Than -> if first_value < second_value then 1 else 0
        | Equal -> if first_value = second_value then 1 else 0
        | _ -> print_string "error 2"; 0
      in
        replace result_position result program

let get_jump_position first_parameter second_parameter old_position opcode command_type program =
  let first_value, second_value = get_values_from_parameters first_parameter second_parameter opcode program
    in
      match command_type with
      | Jump_If_True -> if first_value != 0 then second_value else (old_position + 3)
      | Jump_If_False ->  if first_value = 0 then second_value else (old_position + 3)
      | _ -> print_string "error 3"; 0

let parse_opcode opcode =
  let command_number = opcode mod 100 in
  match command_number with
  | 1 -> Add
  | 2 -> Multiply
  | 3 -> Input
  | 4 -> Output
  | 5 -> Jump_If_True
  | 6 -> Jump_If_False
  | 7 -> Less_Than
  | 8 -> Equal
  | 99 -> Halt
  | _ -> print_string "error 1"; Halt

let rec run_program state =
  let { program; position; inputs; outputs; _ } = state in
    let opcode = List.nth program position in
      let command_type = parse_opcode opcode in
        match command_type with
        | Add | Multiply | Less_Than | Equal -> 
          let new_program =
            perform_operation (List.nth program (position + 1)) (List.nth program (position + 2)) (List.nth program (position + 3)) opcode command_type program
          in
            run_program { state with position = (position + 4); program = new_program }
        | Jump_If_True | Jump_If_False ->
          let new_position =
            get_jump_position (List.nth program (position + 1)) (List.nth program (position + 2)) position opcode command_type program
          in
            run_program { state with position = new_position }
        | Input -> (match inputs with
          | [] -> state
          | hd :: tl -> let new_program = replace (List.nth program (position + 1)) hd program in
            run_program { state with position = (position + 2); program = new_program; inputs = tl })
        | Output -> let output_position = List.nth program (position + 1) in
          let new_output = (List.nth program output_position) in
            run_program { state with position = (position + 2); outputs = outputs @ [new_output] }
        | Halt -> { state with halted = true }

let rec run_feedback_loop amplifiers active =
  let next_active = (active + 1) mod 5 in
    let active_amplifier = List.nth amplifiers active in
      if active_amplifier.halted = true then
        run_feedback_loop amplifiers next_active
      else
        let next_amplifier = List.nth amplifiers next_active in
          let new_amplifier_state = run_program active_amplifier in
            (* print_int (List.hd new_amplifier_state.outputs); *)
            if new_amplifier_state.halted = true && active = 4 then
              List.hd new_amplifier_state.outputs
            else
              let list_next_updated = 
                replace next_active { next_amplifier with inputs = (List.append next_amplifier.inputs new_amplifier_state.outputs) } amplifiers in
                let list_active_updated = replace active { new_amplifier_state with outputs = [] } list_next_updated in
                  run_feedback_loop list_active_updated next_active

let build_amplifier program input index =
  let inputs = if index = 0 then [input; 0] else [input] in
    { program = program;
      position = 0; 
      inputs = inputs;
      outputs = [];
      halted = false }

let calculate_permutation program permutation =
  let amplifiers = List.mapi (fun index x -> build_amplifier program x index) permutation in
    run_feedback_loop amplifiers 0

let rec permutations result other = function
  | [] -> [result]
  | hd :: tl ->
    let r = permutations (hd :: result) [] (other @ tl) in
    if tl <> [] then
      r @ permutations result (hd :: other) tl
    else
      r

let () =
  let perms = permutations [] [] [5; 6; 7; 8; 9] in
    let program = open_in "input"
      |> input_line
      |> String.split_on_char ','
      |> List.map int_of_string
    in
      List.map (fun perm -> calculate_permutation program perm) perms
        |> List.fold_left max 0
        |> print_int; print_newline()