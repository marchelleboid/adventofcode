let rec get_pixel line position layer =
  let c = String.get line (position + layer * 150) in
    if c != '2' then c
    else get_pixel line position (layer + 1)

let rec build_image image position line =
  if position = 150 then (List.rev image)
  else
    build_image ((get_pixel line position 0) :: image) (position + 1) line

let rec print_image row_pixel image =
  if row_pixel = 25 then print_newline();
  if row_pixel = 25 then print_image 0 image
  else
    match image with
    | [] -> print_newline()
    | hd :: tl -> print_char hd; print_image (row_pixel + 1) tl

let () =
  open_in "input"
    |> input_line
    |> build_image [] 0
    |> print_image 0