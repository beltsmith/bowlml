open Base

open Bowling


let rolls = ["4"; "5"; "X"; "8"]

(* let more_rolls = ["4"; "5"; "X"; "8"; "1"] *)

(* let full_strikes = ["X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"] *)
(* let example = ["X"; "9"; "/"; "5"; "/"; "7"] *)
(* let example = ["X"; "9"; "/"; "5"; "/"; "7"; "2"; "X"; "X";] *)
(* let example = ["X"; "9"; "/"; "5"; "/"; "7"; "2"; "X"; "X"; "X"; "9"; "0"; "8"; "/"; "9"; "/"; "X"] *)

(* let cases = [rolls; more_rolls; full_strikes] *)

let display_frame_score = function
  | Some (score) -> Int.to_string score
  | None -> "?"

let () =
  rolls
  |> Input.parse_list
  |> Game.of_inputs
  |> Game.score
  |> List.map ~f:display_frame_score
  |> List.iter ~f:(Stdlib.print_endline)
