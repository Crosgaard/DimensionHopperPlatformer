extends State

@export var idle_state: State
@export var move_state: State
@export var dash_state: State
@export var jump_state: State

@export var jump_buffer: float = 0.75
@export var coyote_time: float = 0.75

var has_sat_jump: bool = false
var jump_buffer_timer: float = 0.0
var coyote_timer: float = 0.0

func enter() -> void:
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
	
	if get_dash() and can_dash():
		return dash_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta

	var movement = get_movement_input() * move_speed
	
	if movement != 0:
		sprite.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		reset_jump()
		set_has_dashed(false)
		if jump_buffer_timer > 0:
			return jump_state
		if movement != 0:
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
