extends State

@export var idle_state: State
@export var return_state: State
@export var shoot_state: State
@export var out_of_dimension_state: State

var last_seen_player: float = 0

func enter() -> void:
	pass

func process_physics(delta: float) -> State:
	
	
	return null

func process_frame(delta: float) -> State:
	return null
