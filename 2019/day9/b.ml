module IntMap = Map.Make(struct type t = int let compare = compare end)

type command = Add | Multiply | Input | Output | Halt | Jump_If_True | Jump_If_False | Less_Than | Equal | Relative_Base_Offset

type parameter_mode = Position | Immediate | Relative

type program_state = {
  program : int IntMap.t;
  position : int;
  inputs : int list;
  outputs : int list;
  relative_base : int;
  halted : bool
}

let number_to_parameter_mode number_as_char =
  match number_as_char with
  | '0' -> Position
  | '1' -> Immediate
  | '2' -> Relative
  | _ -> print_string "error parsing parameter mode"; Position

let get_parameter_mode param_number opcode =
  let opcode_list = string_of_int opcode
    |> String.to_seq
    |> List.of_seq
  in
    match param_number with
    | 1 -> (
      match List.length opcode_list with
      | 1 | 2 -> Position
      | 3 -> number_to_parameter_mode (List.nth opcode_list 0)
      | 4 -> number_to_parameter_mode (List.nth opcode_list 1)
      | _ -> number_to_parameter_mode (List.nth opcode_list 2)
      )
    | 2 -> (
      match List.length opcode_list with
      | 1 | 2 | 3 -> Position
      | 4 -> number_to_parameter_mode (List.nth opcode_list 0)
      | _ -> number_to_parameter_mode (List.nth opcode_list 1)
      )
    | 3 -> (
      match List.length opcode_list with
      | 1 | 2 | 3 | 4 -> Position
      | _ -> number_to_parameter_mode (List.nth opcode_list 0)
      )
    | _ -> print_string "wrong param_number"; Position

let get_actual_parameter_value argument parameter_number opcode state =
  match get_parameter_mode parameter_number opcode with
  | Position -> IntMap.find argument state.program
  | Immediate -> argument
  | Relative -> IntMap.find (argument + state.relative_base) state.program

let get_result_parameter_value argument parameter_number opcode state =
  match get_parameter_mode parameter_number opcode with
  | Position -> argument
  | Immediate -> print_string "immediate result error"; argument
  | Relative -> argument + state.relative_base

let perform_operation first_argument second_argument result_argument opcode command_type state =
  let first_value, second_value, result_position = 
    get_actual_parameter_value first_argument 1 opcode state,
    get_actual_parameter_value second_argument 2 opcode state,
    get_result_parameter_value result_argument 3 opcode state
    in
      let result = 
        match command_type with
        | Add -> first_value + second_value
        | Multiply -> first_value * second_value
        | Less_Than -> if first_value < second_value then 1 else 0
        | Equal -> if first_value = second_value then 1 else 0
        | _ -> print_string "error performing math operation"; 0
      in
        IntMap.add result_position result state.program

let get_jump_position first_argument second_argument old_position opcode command_type state =
  let first_value, second_value = 
    get_actual_parameter_value first_argument 1 opcode state,
    get_actual_parameter_value second_argument 2 opcode state
    in
      match command_type with
      | Jump_If_True -> if first_value != 0 then second_value else (old_position + 3)
      | Jump_If_False ->  if first_value = 0 then second_value else (old_position + 3)
      | _ -> print_string "error jumping"; 0

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
  | 9 -> Relative_Base_Offset
  | 99 -> Halt
  | _ -> print_string "error parsing opcode"; Halt

let rec run_program state =
  let { program; position; inputs; outputs; relative_base; _ } = state in
    let opcode = IntMap.find position program in
      let command_type = parse_opcode opcode in
        match command_type with
        | Add | Multiply | Less_Than | Equal ->
          let new_program =
            perform_operation (IntMap.find (position + 1) program) (IntMap.find (position + 2) program) (IntMap.find (position + 3) program) opcode command_type state
          in
            run_program { state with position = (position + 4); program = new_program }
        | Jump_If_True | Jump_If_False ->
          let new_position =
            get_jump_position (IntMap.find (position + 1) program) (IntMap.find (position + 2) program) position opcode command_type state
          in
            run_program { state with position = new_position }
        | Input -> (match inputs with
          | [] -> state
          | hd :: tl ->
            let input_position = get_result_parameter_value (IntMap.find (position + 1) program) 1 opcode state in
              let new_program = IntMap.add input_position hd program in
                run_program { state with position = (position + 2); program = new_program; inputs = tl })
        | Output -> let new_output = get_actual_parameter_value (IntMap.find (position + 1) program) 1 opcode state in
            run_program { state with position = (position + 2); outputs = outputs @ [new_output] }
        | Relative_Base_Offset ->
          let offset_amount = get_actual_parameter_value (IntMap.find (position + 1) program) 1 opcode state in
            run_program { state with position = (position + 2); relative_base = relative_base + offset_amount }
        | Halt -> { state with halted = true }

let () =
  let program = open_in "input"
    |> input_line
    |> String.split_on_char ','
    |> List.mapi (fun i value -> (i, int_of_string value))
    |> List.fold_left (fun p (i, value) -> IntMap.add i value p) IntMap.empty
  in
    let state = {
      program = program;
      position = 0; 
      inputs = [2];
      outputs = [];
      relative_base = 0;
      halted = false
      }
    in
      let final_state = run_program state in
        print_int (List.hd final_state.outputs); print_newline();
      