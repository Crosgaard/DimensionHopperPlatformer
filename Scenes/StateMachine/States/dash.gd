extends State

@export var dash_vel: float = move_speed * 5

@export var move_state: State
@export var fall_state: State
@export var jump_state: State
@export var idle_state: State

var direction: float = 1.0

var jumped: bool = false

func enter() -> void:
	set_has_dashed(true)

	if sprite.flip_h:
		direction = -1
	else:
		direction = 1
	
	parent.velocity.x = dash_vel * direction
	jumped = false

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if not jumped:
		parent.velocity.x -= accel * direction
	parent.move_and_slide()
	
	return null
