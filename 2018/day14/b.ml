open Core

let recipes = Bigarray.Array1.create Bigarray.int8_unsigned Bigarray.c_layout 100000000

let get_new_location elf_position recipe length = (elf_position + recipe + 1) mod length

let check_for_key start =
  (recipes.{start} = 9 &&
  recipes.{start + 1} = 9 &&
  recipes.{start + 2} = 0 &&
  recipes.{start + 3} = 9 &&
  recipes.{start + 4} = 4 &&
  recipes.{start + 5} = 1) ||
  (recipes.{start + 1} = 9 &&
  recipes.{start + 2} = 9 &&
  recipes.{start + 3} = 0 &&
  recipes.{start + 4} = 9 &&
  recipes.{start + 5} = 4 &&
  recipes.{start + 6} = 1)

let rec find_recipes elf_1 elf_2 next_position =
  if next_position > 7 && (check_for_key (next_position - 7)) then 
    next_position - 7
  else
    let elf_1_recipe = recipes.{elf_1} in
      let elf_2_recipe = recipes.{elf_2} in
        let new_recipe = elf_1_recipe + elf_2_recipe in
          let new_next_position = (if new_recipe >= 10 then
              (recipes.{next_position} <- 1;
              recipes.{next_position + 1} <- new_recipe - 10;
              next_position + 2)
            else
              (recipes.{next_position} <- new_recipe;
              next_position + 1))
            in
              find_recipes 
                (get_new_location elf_1 elf_1_recipe new_next_position)
                (get_new_location elf_2 elf_2_recipe new_next_position)
                new_next_position

let () =
  recipes.{0} <- 3;
  recipes.{1} <- 7;
  find_recipes 0 1 2 |> printf "%d\n"