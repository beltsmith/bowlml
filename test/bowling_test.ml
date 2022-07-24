open Bowling
open Base

let more_rolls = ["4"; "5"; "X"; "8"; "1"]

(* let full_strikes = ["X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"] *)
(* let example = ["X"; "9"; "/"; "5"; "/"; "7"] *)
(* let example = ["X"; "9"; "/"; "5"; "/"; "7"; "2"; "X"; "X";] *)
(* let example = ["X"; "9"; "/"; "5"; "/"; "7"; "2"; "X"; "X"; "X"; "9"; "0"; "8"; "/"; "9"; "/"; "X"] *)

let show scores =
  let show_score = function
    | Some (score) -> Printf.sprintf "Some %i" score
    | None -> "None" in
  List.map scores ~f:show_score |> String.concat ~sep:"; "

let score_raw_rolls rolls =
  rolls |> Input.parse_list |> Game.score_inputs

let print_scores rolls =
  score_raw_rolls rolls
  |> show
  |> Stdlib.print_endline

let compare_int_option_list =
  List.equal (Option.equal (=))

let%expect_test "one roll after strike" =
  print_scores ["4"; "5"; "X"; "8"];
  [%expect {| Some 9; None |}]

let%expect_test "two rolls after strike" =
  print_scores ["4"; "5"; "X"; "8"; "1"];
  [%expect {| Some 9; Some 19; Some 9 |}]

let%expect_test "perfect game" =
  print_scores ["X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"; "X"];
  [%expect {| Some 30; Some 30; Some 30; Some 30; Some 30; Some 30; Some 30; Some 30; Some 30; Some 30 |}]

let%expect_test "turkey" =
  print_scores ["X"; "X"; "X"];
  [%expect {| Some 30; None; None |}]

let%expect_test "average game" =
  print_scores ["X"; "9"; "/"; "5"; "/"; "7"; "2"; "X"; "X"; "X"; "9"; "0"; "8"; "/"; "9"; "/"; "X"];
  [%expect {| Some 20; Some 15; Some 17; Some 9; Some 30; Some 29; Some 19; Some 9; Some 19; Some 20 |}]
