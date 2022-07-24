type t = Int of int | String of string

val parse_roll : int -> t -> Roll.t
val parse : string -> t
val parse_list : string list -> t list
