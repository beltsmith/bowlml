type t =
  | Skip
  | Score of int
  | Strike
  | Spare of int
[@@deriving show]

val real_roll : t -> bool
val is_strike : t -> bool
val is_spare : t -> bool
val take : int -> t list -> t list
val sum : t list -> int
val hd : t list -> t
val value : int option -> int
