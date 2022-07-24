type t = Frame.t list
[@@deriving show]

val score : t ->  int option list
val of_inputs : Input.t list -> t
val final_score : t -> int
val score_inputs : Input.t list -> int option list
val running_score : t -> int list
val running_score_of_inputs : Input.t list -> int list
