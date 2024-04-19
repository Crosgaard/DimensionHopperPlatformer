extends State

@export var return_state: State
@export var target_state: State
@export var shoot_state: State
@export var out_of_dimension_state: State

func enter() -> void:
	pass

func process_physics(delta: float) -> State:
	var player = parent.full_level_parent.get_player()
	var result = parent.line_of_site_cast(parent.position, player.position)
	
	if result.collider == player:
		return target_state
	return null

func process_frame(delta: float) -> State:
	return null

