open Core

type claim =
{
  id: int;
  x: int;
  y: int;
  width: int;
  height: int;
}

let create_fabric = Bigarray.Array2.create Bigarray.int8_unsigned Bigarray.c_layout 1000 1000

let line_to_claim line =
  Scanf.sscanf line "#%d @ %d,%d: %dx%d" (fun id x y w h -> 
    {
        id = id;
        x = x;
        y = y;
        width = w;
        height = h;
    })

let update_fabric fabric claim =
  for i = claim.x to claim.x + claim.width - 1 do
    for j = claim.y to claim.y + claim.height - 1 do
      match fabric.{i, j} with
      | 0 -> fabric.{i, j} <- 1
      | 1 -> fabric.{i, j} <- 2
      | _ -> ()
    done
  done;
  fabric

let is_claim_unique fabric claim = 
  let unique = ref true in
    for i = claim.x to claim.x + claim.width - 1 do
      for j = claim.y to claim.y + claim.height - 1 do
        match fabric.{i, j} with
        | 2 -> unique := false
        | _ -> ()
      done
    done;
    !unique

let rec find_unique_claim fabric claims =
  match claims with
  | [] -> 0
  | hd :: tl -> if is_claim_unique fabric hd then hd.id else find_unique_claim fabric tl

let () =
  let claims = List.map ~f:line_to_claim (In_channel.read_lines "input") in
    let claimed_fabric = List.fold ~init:create_fabric ~f:update_fabric claims in
      printf "%d\n" (find_unique_claim claimed_fabric claims)
