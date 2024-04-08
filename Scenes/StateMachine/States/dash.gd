extends State

@export var time_to_dash: float = 0.2
@export var time_to_jump_boost: float = 0.1

@export var move_state: State
@export var fall_state: State
@export var jump_state: State
@export var idle_state: State

var dash_timer: float = 0.0
var direction: float = 1.0

func enter() -> void:
	set_has_dashed(true)
	dash_timer = time_to_dash

	if sprite.flip_h:
		direction = -1
	else:
		direction = 1

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	dash_timer -= delta
	if dash_timer > 0.0:
		parent.velocity.x = direction * move_speed
	else:
		if not parent.is_on_floor():
			return idle_state
		var movement = get_movement_input() * move_speed
		if movement != 0.0:
			return move_state
		return idle_state
	
	return null
