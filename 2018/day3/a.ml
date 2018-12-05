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

let rec count_multiple_claims fabric ij count =
  match ij with
  | (1000, _) -> count
  | (i, 1000) -> count_multiple_claims fabric (i + 1, 0) count
  | (i, j) ->
    match fabric.{i, j} with
    | 2 -> count_multiple_claims fabric (i, j + 1) (count + 1)
    | _ -> count_multiple_claims fabric (i, j + 1) count

let () =
  let claims = List.map ~f:line_to_claim (In_channel.read_lines "input") in
    let claimed_fabric = List.fold ~init:create_fabric ~f:update_fabric claims in
      printf "%d\n" (count_multiple_claims claimed_fabric (0,0) 0)
    
