open Base

type t = Frame.t list
[@@deriving show]
type in_progress = Input.t list

let total_frames = 10
(* type in_progress = t * Roll.t list *)

let is_final_frame game =
  List.length game = total_frames - 1

(* append infix operator *)
let (<+) game frame =
  List.append game [frame]

(* append rolls as a frame to game *)
let (<<+) game rolls =
  let frame_of =
    if is_final_frame game
    then Frame.of_rolls_final
    else Frame.of_rolls in
  let frame = frame_of rolls in
  game <+ frame

let strike_in_frame rolls =
  Roll.is_strike (Roll.hd rolls)

let spare_in_frame rolls =
  match List.find ~f:Roll.is_spare rolls with
  | Some _ -> true
  | None -> false


let game_over game =
  List.length game = total_frames

let rolls_for_frame game rolls =
  let threw_strike = strike_in_frame rolls in
  let threw_spare = spare_in_frame rolls in
  if is_final_frame game
  then if threw_strike || threw_spare
    then 3 (* getting a strike in the final frame allows two more rolls, a spare allows one additional  *)
    else 2
  else if threw_strike
  then 1 (* having a strike in any other frame concludes the frame *)
  else 2 (* otherwise you have 2 rolls per frame *)


let accumulate_frames (game, rolls) roll_in =
  let pins = 10 - (Roll.sum rolls % 10) in
  let roll = Input.parse_roll pins roll_in in
  let rolls = rolls <+ roll in
  let rolls_in_frame = rolls_for_frame game rolls in
  let final_roll_of_frame =
    List.length rolls >= rolls_in_frame in
  if game_over game
  then (game, []) (* sotop accumulating rolls *)
  else if final_roll_of_frame
  then (game <<+ rolls, []) (* add rolls as frame to game *)
  else (game, rolls) (* add roll to current frame *)

let score frames =
  let rec acc scores = function
    | frame :: fs ->
      let score = Frame.score frame fs in
      acc (score :: scores) fs
    | [] -> scores in
  acc [] frames |> List.rev

let frames rolls =
  match rolls |> List.fold_left ~init:([], []) ~f:accumulate_frames with
  | (frames, _) -> frames

let sum_options =
  List.sum (module Int) ~f:(Option.value ~default:0)

let final_score frames =
  score frames
  |> sum_options

let of_inputs = frames

let score_inputs inputs =
  of_inputs inputs |> score

let running_score frames =
  let scores = score frames in
  let rec acc sums = function
    | s :: ss ->
      let sum = [List.hd sums; s] |> sum_options in
      acc (sum :: sums) ss
    | _ -> sums in
  acc [] scores |> List.rev

let running_score_in_progress rolls =
  rolls
  |> frames
  |> running_score
