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
	# Camera shake
	var shake: Vector2 = Vector2(25.0, 5.0)
	var shake_fade: float = 8.0
	if abs(parent.velocity.y) < 80:
		shake *= 3
		shake_fade /= 2
	parent.shake_camera(shake.x * get_direction() * -1, shake.y, shake_fade)
	
	parent.velocity.y = 0
	dash_deccel = accel
	dash_start_time = Time.get_ticks_msec()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	if get_jump() and Time.get_ticks_msec() - dash_start_time > 75:
		# Camera shake
		var shake: Vector2 = Vector2(20.0, -30.0)
		var shake_fade: float = 6.0
		var mulitplier: float = 1.2
		if parent.velocity.x >= 1000.0:
				shake *= mulitplier
		
		if parent.velocity.x >= 1250.0:
				shake *= mulitplier
			
		if parent.velocity.x >= 1500.0:
				shake *= mulitplier
		parent.shake_camera(shake.x * get_direction(), shake.y, shake_fade)
		
		return jump_state
	return null

func process_physics(delta: float) -> State:
	
	if abs(parent.velocity.x - dash_deccel * get_direction()) < move_state.max_move_speed:
		return fall_state
	parent.velocity.x -= dash_deccel * get_direction()
		
	parent.move_and_slide()
	
	return null
