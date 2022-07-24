open Base

type t =
  | Skip
  | Score of int
  | Strike
  | Spare of int
[@@deriving show]

let no_score = Skip
let no_score_value = 0
let total_pins = 10

(* Helpers to unwrap option *)
let value =
  Option.value ~default:no_score_value

let score =
  Option.value ~default:no_score

let real_roll = function
  | Skip -> false
  | _ -> true

let roll_score = function
  | Skip -> no_score_value
  | Score score -> score
  | Strike -> total_pins
  | Spare score -> score

let sum rolls =
  List.map ~f:roll_score rolls
  |> List.reduce ~f:(+)
  |> value


let is_strike = function
  | Strike -> true
  | _ -> false

let is_spare = function
  | Spare _ -> true
  | _ -> false

let take n rolls =
  List.take rolls n

let hd rolls =
  List.hd rolls |> score
