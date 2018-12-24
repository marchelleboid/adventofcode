open Core

type operation =
{
  before: int array;
  after: int array;
  opcode: int;
  a: int;
  b: int;
  c: int
}

let apply_operation op registers a b =
  match op with
  | "addr" -> registers.(a) + registers.(b)
  | "addi" -> registers.(a) + b
  | "mulr" -> registers.(a) * registers.(b)
  | "muli" -> registers.(a) * b
  | "banr" -> registers.(a) land registers.(b)
  | "bani" -> registers.(a) land b
  | "borr" -> registers.(a) lor registers.(b)
  | "bori" -> registers.(a) lor b
  | "setr" -> registers.(a)
  | "seti" -> a
  | "gtir" -> if a > registers.(b) then 1 else 0
  | "gtri" -> if registers.(a) > b then 1 else 0
  | "gtrr" -> if registers.(a) > registers.(b) then 1 else 0
  | "eqir" -> if a = registers.(b) then 1 else 0
  | "eqri" -> if registers.(a) = b then 1 else 0
  | "eqrr" -> if registers.(a) = registers.(b) then 1 else 0
  | _ -> 0

let check_operation op operation =
  operation.after.(operation.c) = apply_operation op operation.before operation.a operation.b
  
let operations = [
  "addr"; "addi"; "mulr"; "muli"; "banr"; "bani"; "borr"; "bori";
  "setr"; "seti"; "gtir"; "gtri"; "gtrr"; "eqir"; "eqri"; "eqrr"
]

let get_possible_operations operation = 
  List.filter operations ~f:(fun op -> (check_operation op operation))
    |> String.Set.of_list

let befores input = List.filter input ~f:(fun x -> String.is_prefix x ~prefix:"Before")
let afters input = List.filter input ~f:(fun x -> String.is_prefix x ~prefix:"After")
let operations input = List.filter input ~f:(fun x -> not (String.contains x ':'))

let parse_before line = Scanf.sscanf line "Before: [%d, %d, %d, %d]" (fun a b c d -> [|a; b; c; d|])
let parse_after line = Scanf.sscanf line "After: [%d, %d, %d, %d]" (fun a b c d -> [|a; b; c; d|])
let parse_operation line = Scanf.sscanf line "%d %d %d %d" (fun a b c d -> [|a; b; c; d|])

let rec zip3_map befores afters operations accum =
  match befores with
  | [] -> accum
  | hdb :: tlb ->
    match afters with
    | [] -> accum
    | hda :: tla ->
      match operations with
      | [] -> accum
      | hdo :: tlo ->
        let parsed_operation = parse_operation hdo in
          zip3_map tlb tla tlo ({
            before = parse_before hdb;
            after = parse_after hda;
            opcode = parsed_operation.(0);
            a = parsed_operation.(1);
            b = parsed_operation.(2);
            c = parsed_operation.(3)
          } :: accum)

let fill_initial_opcode_mapping accum operation =
  match Map.find accum operation.opcode with
  | Some x when Set.length x = 1 -> accum
  | y ->
    let possible_ops = get_possible_operations operation in
      let ops = match y with
      | None -> possible_ops
      | Some x -> Set.inter possible_ops x
      in
        Map.set accum ~key:operation.opcode ~data:ops

let rec figure_out_opcodes initial_mapping final_mapping =
  match Map.is_empty initial_mapping with
  | true -> final_mapping
  | false ->
    let ready_opcodes = Map.filter initial_mapping ~f:(fun v -> Set.length v = 1)
      |> Map.map ~f:(fun v -> Set.choose_exn v) in
      let new_final_mapping = Map.fold ready_opcodes ~init:final_mapping ~f:(fun ~key ~data a -> Map.set a ~key:key ~data:data) in
        let removed_initial_mapping = Map.fold ready_opcodes ~init:initial_mapping ~f:(fun ~key ~data:_ a -> Map.remove a key) in
          let new_initial_mapping = Map.fold ready_opcodes ~init:removed_initial_mapping ~f:(fun ~key:_ ~data a -> Map.map a ~f:(fun v -> Set.remove v data)) in
            figure_out_opcodes new_initial_mapping new_final_mapping

let run_operation opcode_mapping registers op =
  let operation_name = Map.find_exn opcode_mapping op.(0) in
    let new_value = apply_operation operation_name registers op.(1) op.(2) in
      registers.(op.(3)) <- new_value; registers

let () =
  let input = In_channel.read_lines "inputa"
    |> List.filter ~f:(fun x -> not (String.is_empty x))
  in
    let initial_opcode = zip3_map (befores input) (afters input) (operations input) []
      |> List.fold ~init:Int.Map.empty ~f:fill_initial_opcode_mapping in
      let final_opcodes = figure_out_opcodes initial_opcode Int.Map.empty in
        let registers = In_channel.read_lines "inputb"
          |> List.map ~f:parse_operation
          |> List.fold ~init:[|0; 0; 0; 0;|] ~f:(fun accum op -> run_operation final_opcodes accum op) in
          printf "%d\n" registers.(0)
        
      