extends State

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State
@export var dash_state: State

func process_input(event: InputEvent) -> State:
	if get_jump() and get_can_jump():
		return jump_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var movement_accel: float = get_movement_input() * accel

	if movement_accel != 0:
		sprite.flip_h = parent.velocity.x < 0
		if get_movement_input() * (parent.velocity.x / abs(parent.velocity.x)) == -1:
			movement_accel *= floor_friction
		print(movement_accel)
		parent.velocity.x += movement_accel
		if abs(parent.velocity.x) > max_move_speed:
			parent.velocity.x = max_move_speed * (parent.velocity.x / abs(parent.velocity.x))
	
	if get_movement_input() == 0.0 and parent.velocity.x != 0.0:
		var deccel: float = parent.velocity.x / abs(parent.velocity.x) * accel * -floor_friction
		parent.velocity.x += deccel
		var tolerance: float = 30
		if abs(parent.velocity.x) < tolerance:
			parent.velocity.x = 0.0
	
	print(parent.velocity.x)
	
	if get_movement_input() == 0.0 and parent.velocity.x == 0.0:
		return idle_state
	
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
