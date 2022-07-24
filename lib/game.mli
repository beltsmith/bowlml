type t = Frame.t list
[@@deriving show]
type in_progress = Input.t list

val score : t ->  int option list
val of_inputs : in_progress -> t
val final_score : t -> int
val score_inputs : Input.t list -> int option list
val running_score : t -> int list
val running_score_in_progress : Input.t list -> int list
