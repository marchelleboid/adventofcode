open Core

let recipes = Bigarray.Array1.create Bigarray.int8_unsigned Bigarray.c_layout 1000000

let get_new_location elf_position recipe length = (elf_position + recipe + 1) mod length

let rec fill_recipes elf_1 elf_2 next_position =
  if next_position > (990941 + 10) then ()
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
              fill_recipes 
                (get_new_location elf_1 elf_1_recipe new_next_position)
                (get_new_location elf_2 elf_2_recipe new_next_position)
                new_next_position

let () =
  recipes.{0} <- 3;
  recipes.{1} <- 7;
  fill_recipes 0 1 2;
  for i = 990941 to 990950 do
    printf "%d\n" recipes.{i};
  done