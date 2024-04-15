extends State

@export var move_state: State
@export var fall_state: State
@export var jump_state: State
@export var idle_state: State

var jumped: bool = false

var dash_start_time: int = 0
var dash_deccel: float

func enter() -> void:
	super()
	set_has_dashed(true)
	
	parent.velocity.x = max_move_speed * get_direction()
	parent.velocity.y = 0
	dash_deccel = accel
	dash_start_time = Time.get_ticks_msec()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	if get_jump() and Time.get_ticks_msec() - dash_start_time > 75:
		return jump_state
	return null

func process_physics(delta: float) -> State:
	
	if abs(parent.velocity.x - dash_deccel * get_direction()) < move_state.max_move_speed:
		return fall_state
	parent.velocity.x -= dash_deccel * get_direction()
		
	parent.move_and_slide()
	
	return null
