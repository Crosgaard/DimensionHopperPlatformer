extends State

@export var idle_state: State
@export var return_state: State
@export var target_state: State
@export var out_of_dimension_state: State

@export var range: float

func enter() -> void:
	pass

func process_physics(delta: float) -> State:
	var player = parent.full_level_parent.get_player()
	var result = parent.line_of_site_cast(parent.position, player.position)
	
	var dist = parent.full_level_parent.get_player().position - parent.position
	
	if dist.length() > range:
			return target_state
	
	if result.collider == parent.full_level_parent.get_player():
		print("shot")
	else:
		return target_state
		
	return null

func toggle_dimension() -> State:
	return out_of_dimension_state
