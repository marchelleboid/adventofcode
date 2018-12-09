open Core

type element =
{
  value: int;
  mutable pointers: element Char.Map.t; 
}

type game_state =
{
  circle: element;
  players: int array;
  current_player: int;
}

let previous el = Map.find_exn el.pointers 'p'

let next el = Map.find_exn el.pointers 'n'

let rec go_back_n_elements el n =
  match n with
  | 0 -> el
  | _ -> go_back_n_elements (previous el) (n - 1)

let rec play_game state marble =
  match marble with
  | 70785 -> state
  | _ ->
      if marble mod 23 = 0 then
        let remove_element = go_back_n_elements state.circle 7 in
          let before_element = previous remove_element in
            let after_element = next remove_element in
              Array.set state.players state.current_player ((Array.get state.players state.current_player) + marble + remove_element.value);
              before_element.pointers <- Map.set before_element.pointers ~key:'n' ~data:after_element;
              after_element.pointers <- Map.set after_element.pointers ~key:'p' ~data:before_element;
              play_game
              {
                circle = after_element;
                players = state.players;
                current_player = (state.current_player + 1) mod 452
              }
              (marble + 1)
      else
        let before_element = next state.circle in
          let after_element = next before_element in
            let new_element = {value = marble; pointers = Char.Map.of_alist_exn ['p',before_element;'n',after_element]} in
              before_element.pointers <- Map.set before_element.pointers ~key:'n' ~data:new_element;
              after_element.pointers <- Map.set after_element.pointers ~key:'p' ~data:new_element;
              play_game 
              {
                circle = new_element;
                players = state.players;
                current_player = (state.current_player + 1) mod 452
              }
              (marble + 1)

let () =
  let element_0 = {value = 0; pointers = Char.Map.empty} in
    let element_1 = {value = 1; pointers = Char.Map.of_alist_exn ['p',element_0;'n',element_0]} in
      element_0.pointers <- Char.Map.of_alist_exn ['p',element_1;'n',element_1];
      let end_game = play_game {circle = element_1; players = Array.create ~len:452 0; current_player = 1} 2
        in Array.fold end_game.players ~init:0 ~f:max
          |> printf "%d\n"