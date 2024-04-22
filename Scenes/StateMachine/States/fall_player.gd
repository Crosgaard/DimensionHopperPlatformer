extends State

@export var idle_state: State
@export var move_state: State
@export var dash_state: State
@export var jump_state: State

@export var coyote_time: float = 0.1

var has_sat_jump: bool = false
var coyote_timer: float = 0.0

func enter() -> void:
	super()
	jump_buffer_timer = 0.0
	
	if prev_state != jump_state:
		coyote_timer = coyote_time
		has_sat_jump = false
	else:
		coyote_timer = 0
		set_jump()
		has_sat_jump = true

func process_input(event: InputEvent) -> State:
	if get_jump(): 
		if get_can_jump():
			return jump_state
		else:
			jump_buffer_timer = jump_buffer
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var movement_accel: float = get_movement_input() * accel
	if movement_accel != 0 and abs(parent.velocity.x + movement_accel) < max_move_speed:
		sprite.flip_h = parent.velocity.x < 0
		parent.velocity.x += movement_accel
	
	if get_movement_input() == 0.0 and parent.velocity.x != 0.0:
		var deccel: float = parent.velocity.x / abs(parent.velocity.x) * accel * -1
		parent.velocity.x += deccel
		if abs(parent.velocity.x) < tolerance:
			parent.velocity.x = 0.0
	
	parent.move_and_slide()
	
	if parent.is_on_floor():
		reset_jump()
		set_has_dashed(false)
		# Bunny hop
		if jump_buffer_timer > 0:
			if jump_buffer_timer < jump_buffer and jump_buffer_timer > (jump_buffer - bunny_hop) and get_movement_input() != 0:
				parent.velocity.x += max_move_speed / 3 * get_direction()
				var max_multiplier: float = 2.8
				parent.velocity.x = min(max_move_speed * max_multiplier, parent.velocity.x)
			
			return jump_state
		if parent.velocity.x != 0:
			return move_state
		return idle_state
	return null

func process_frame(delta: float) -> State:
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta
	
	if coyote_timer > 0:
		coyote_timer -= delta
	elif not has_sat_jump:
		set_jump()
		has_sat_jump = true
	
	return null
