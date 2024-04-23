extends State

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State
@export var dash_state: State

var extra_friction: float = 2.0
var extra_friction_timer: float = 2.0
var has_bunny_hopped: bool = false

func enter() -> void:
	super()
	jump_buffer_timer = bunny_hop
	has_bunny_hopped = false

func process_input(event: InputEvent) -> State:
	if get_jump() and get_can_jump():
		if jump_buffer_timer > 0 and get_movement_input() != 0:
				parent.velocity.x += max_move_speed / 3 * get_direction()
				parent.velocity.x = min(max_move_speed * 2, parent.velocity.x)
		return jump_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var movement_accel: float = get_movement_input() * accel

	if movement_accel != 0:
		sprite.flip_h = parent.velocity.x < 0
		if get_movement_input() * (parent.velocity.x / abs(parent.velocity.x)) == -1:
			movement_accel *= floor_friction
		parent.velocity.x += movement_accel
		if abs(parent.velocity.x) > max_move_speed:
			parent.velocity.x = max_move_speed * (parent.velocity.x / abs(parent.velocity.x))
	
	if get_movement_input() == 0.0 and parent.velocity.x != 0.0:
		var deccel: float = parent.velocity.x / abs(parent.velocity.x) * accel * -floor_friction
		parent.velocity.x += deccel
		var tolerance: float = 30
		if abs(parent.velocity.x) < tolerance:
			parent.velocity.x = 0.0
	
	if get_movement_input() == 0.0 and parent.velocity.x == 0.0:
		return idle_state
	
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null

func process_frame(delta: float) -> State:
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta
	elif not has_bunny_hopped:
		has_bunny_hopped = true
		floor_friction = standard_floor_friction * extra_friction
	
	if has_bunny_hopped and extra_friction_timer > 0:
		extra_friction_timer -= delta
	elif extra_friction_timer <= 0 && floor_friction != standard_floor_friction:
		floor_friction = standard_floor_friction
	return null
