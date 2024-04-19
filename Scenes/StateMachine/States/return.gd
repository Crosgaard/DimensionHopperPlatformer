extends State

@export var idle_state: State
@export var target_state: State
@export var shoot_state: State
@export var out_of_dimension_state: State

@export var follow_speed: float

func enter() -> void:
	pass

func process_physics(delta: float) -> State:
	var result = parent.line_of_site_cast(parent.position, parent.home_pos)
	
	if result == {}:
		var dist = parent.home_pos - parent.position
		parent.position = parent.position + dist / dist.length() * follow_speed
	
		if dist.length() < 10:
			parent.position = parent.home_pos
			return idle_state
		
	return null

func process_frame(delta: float) -> State:
	return null
