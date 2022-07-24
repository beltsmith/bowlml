open Base

(* type roll = Roll.t *)

type t =
  | Frame of Roll.t * Roll.t
  | FinalFrame of Roll.t * Roll.t * Roll.t
[@@deriving show]

let of_rolls_final = function
  | r1 :: r2 :: r3 :: _ -> FinalFrame (r1, r2, r3)
  | r1 :: r2 :: _ -> FinalFrame (r1, r2, Skip)
  | _ -> FinalFrame (Skip, Skip, Skip)

let of_rolls = function
  | r1 :: r2 :: _ -> Frame (r1, r2)
  | r1 :: _ -> Frame (r1, Skip)
  | _ -> Frame (Skip, Skip)

let frame_rolls = function
  | Frame (r1, r2) -> [r1; r2]
  | FinalFrame (r1, r2, r3) -> [r1; r2; r3]

let frame_value frame =
  frame_rolls frame |> Roll.sum

let to_rolls frames =
  List.(concat_map ~f:frame_rolls frames |> filter ~f:Roll.real_roll)

let is_strike frame =
  match frame with
  | Frame (roll, _ ) | FinalFrame (roll, _, _) -> Roll.is_strike roll

let is_spare frame =
  match frame with
  | Frame (_, roll) | FinalFrame (_, roll, _) -> Roll.is_spare roll

let next_two_rolls frames =
  to_rolls frames |> Roll.take 2

let next_roll frames =
  to_rolls frames |> Roll.hd

let score_strike roll frames =
  let rolls = next_two_rolls frames in
  if List.length rolls >= 2
  then Some (roll :: rolls |> Roll.sum)
  else None

let score_spare rolls frames =
  match next_roll frames with
  | Skip -> None
  | roll -> Some (roll :: rolls |> Roll.sum)

let score frame frames =
  match frame with
  | FinalFrame (_, _, _) -> Some (frame_rolls frame |> Roll.sum)
  | Frame (r1, _) when is_strike frame -> score_strike r1 frames
  | Frame (r1, r2) when is_spare frame -> score_spare [r1; r2] frames
  | _ -> Some (frame_value frame)
