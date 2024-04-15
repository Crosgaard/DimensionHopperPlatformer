extends State

@export var fall_state: State
@export var idle_state: State
@export var move_state: State
@export var dash_state: State

@export var jump_force: float = 350.0

func enter() -> void:
	super()
	set_jump()
	parent.velocity.y = -jump_force

func process_input(event: InputEvent) -> State:
	if get_dash() and can_dash():
		return dash_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	if parent.velocity.y > 0:
		return fall_state
	
	var movement_accel: float = get_movement_input() * accel
	if movement_accel != 0 and abs(parent.velocity.x + movement_accel) < max_move_speed:
		sprite.flip_h = parent.velocity.x < 0
		parent.velocity.x += movement_accel
	
	if get_movement_input() == 0.0 and parent.velocity.x != 0.0:
		var deccel: float = parent.velocity.x / abs(parent.velocity.x) * accel * -1
		parent.velocity.x += deccel
		var tolerance: float = 30
		if abs(parent.velocity.x) < tolerance:
			parent.velocity.x = 0.0
	
	parent.move_and_slide()
	
	if parent.is_on_floor():
		reset_jump()
		set_has_dashed(false)
		if parent.velocity.x != 0:
			return move_state
		return idle_state
	
	return null
