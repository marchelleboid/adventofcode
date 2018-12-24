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

let check_addr before after a b c = after.(c) = (before.(a) + before.(b))
let check_addi before after a b c = after.(c) = (before.(a) + b)
let check_mulr before after a b c = after.(c) = (before.(a) * before.(b))
let check_muli before after a b c = after.(c) = (before.(a) * b)
let check_banr before after a b c = after.(c) = (before.(a) land before.(b))
let check_bani before after a b c = after.(c) = (before.(a) land b)
let check_borr before after a b c = after.(c) = (before.(a) lor before.(b))
let check_bori before after a b c = after.(c) = (before.(a) lor b)
let check_setr before after a _ c = after.(c) = before.(a)
let check_seti _ after a _ c = after.(c) = a
let check_gtir before after a b c = after.(c) = if a > before.(b) then 1 else 0
let check_gtri before after a b c = after.(c) = if before.(a) > b then 1 else 0
let check_gtrr before after a b c = after.(c) = if before.(a) > before.(b) then 1 else 0
let check_eqir before after a b c = after.(c) = if a = before.(b) then 1 else 0
let check_eqri before after a b c = after.(c) = if before.(a) = b then 1 else 0
let check_eqrr before after a b c = after.(c) = if before.(a) = before.(b) then 1 else 0

let operations = [
  check_addr; check_addi; check_mulr; check_muli; check_banr; check_bani; check_borr; check_bori;
  check_setr; check_seti; check_gtir; check_gtri; check_gtrr; check_eqir; check_eqri; check_eqrr;
]

let satisfies_more_than_3 before after a b c =
  List.length (List.filter operations ~f:(fun f -> (f before after a b c))) >= 3

let befores input =
  List.filter input ~f:(fun x -> String.is_prefix x ~prefix:"Before")

let afters input =
  List.filter input ~f:(fun x -> String.is_prefix x ~prefix:"After")

let operations input =
  List.filter input ~f:(fun x -> not (String.contains x ':'))

let parse_before line =
  Scanf.sscanf line "Before: [%d, %d, %d, %d]" (fun a b c d -> [|a; b; c; d|])

let parse_after line =
  Scanf.sscanf line "After: [%d, %d, %d, %d]" (fun a b c d -> [|a; b; c; d|])

let parse_operation line =
  Scanf.sscanf line "%d %d %d %d" (fun a b c d -> [|a; b; c; d|])

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

let () =
  let input = In_channel.read_lines "inputa"
    |> List.filter ~f:(fun x -> not (String.is_empty x))
  in
    zip3_map (befores input) (afters input) (operations input) []
      |> List.filter ~f:(fun o -> satisfies_more_than_3 o.before o.after o.a o.b o.c)
      |> List.length
      |> printf "%d\n"