type t =
  | Frame of Roll.t * Roll.t
  | FinalFrame of Roll.t * Roll.t * Roll.t
[@@deriving show]

val score : t -> t list -> int option
val of_rolls_final : Roll.t list -> t
val of_rolls : Roll.t list -> t
