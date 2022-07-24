open Base

type t = Int of int | String of string

let parse_int str =
  try Some (Int.of_string str) with
    Failure _ -> None

let is_int str =
  match parse_int str with
  | Some (_) -> true
  | None -> false

let parse_roll pins = function
  | String ("X") -> Roll.Strike
  | String ("/") -> Roll.Spare (pins)
  | Int (roll) -> Roll.Score (roll)
  | _ -> Roll.Skip

let parse input =
  if is_int input
  then Int (parse_int input |> Roll.value)
  else String (input)

let parse_list inputs =
  List.map ~f:parse inputs
