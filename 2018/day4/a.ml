open Core

type record =
{
  minute: int;
  action: string;
}

type state =
{
  current_guard: int;
  fall_asleep_time: int;
  sleep_map: (int, int array, Int.comparator_witness) Map.t;
}

let initial_state = {current_guard = 0; fall_asleep_time = 0; sleep_map = Int.Map.empty}

let line_to_record line =
  let matches =
    Re.exec (Re.Perl.compile_pat "\\[\\d+-\\d+-\\d+ \\d+:(\\d+)\\] (.+)") line
  in
  {
    minute = Int.of_string (Re.get matches 1);
    action = Re.get matches 2;
  }

let handle_record state record =
  match String.get record.action 0 with
  | 'G' ->
    let guard_id = Scanf.sscanf record.action "Guard #%d begins shift" (fun id -> id) in
      let new_sleep_map = match Map.find state.sleep_map guard_id with
        | None -> Map.set state.sleep_map ~key:guard_id ~data:(Array.create ~len:60 0)
        | Some(_) -> state.sleep_map
      in {current_guard = guard_id; fall_asleep_time = 0; sleep_map = new_sleep_map}
  | 'f' -> {current_guard = state.current_guard; fall_asleep_time = record.minute; sleep_map = state.sleep_map}
  | _ ->
    let new_sleep_map = match Map.find state.sleep_map state.current_guard with
      | None -> state.sleep_map
      | Some(minutes) ->
        for i = state.fall_asleep_time to record.minute - 1 do
          minutes.(i) <- minutes.(i) + 1
        done;
        state.sleep_map
    in {current_guard = state.current_guard; fall_asleep_time = 0; sleep_map = new_sleep_map}

let accumulate_minutes index accumulator minutes_slept =
  let (total, sleepiest_minute, sleepiest_minute_value) = accumulator in
    if minutes_slept > sleepiest_minute_value then
    (total + minutes_slept, index, minutes_slept)
    else
    (total + minutes_slept, sleepiest_minute, sleepiest_minute_value)

let handle_guard ~key ~data accumulator =
  let (minutes_slept, sleepiest_minute, _) =
    Array.foldi ~init:(0,0,0) ~f:accumulate_minutes data
  in
    let (_, highest_minutes_slept, _) = accumulator in
      if minutes_slept > highest_minutes_slept then
      (key, minutes_slept, sleepiest_minute)
      else
      accumulator

let find_biggest_sleeper sleep_map =
  Map.fold ~init:(0,0,0) ~f:handle_guard sleep_map

let () =
  let sleep_state = In_channel.read_lines "sorted_input"
    |> List.map ~f:line_to_record
    |> List.fold ~init:initial_state ~f:handle_record
  in
    let (guard_id, _, sleepiest_minute) = find_biggest_sleeper sleep_state.sleep_map in
      printf "%d %d %d\n" guard_id sleepiest_minute (guard_id * sleepiest_minute)
    