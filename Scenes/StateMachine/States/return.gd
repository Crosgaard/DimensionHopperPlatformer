extends State

@export var idle_state: State
@export var target_state: State
@export var shoot_state: State

func enter() -> void:
	pass

func process_physics(delta: float) -> State:
	return null

func process_frame(delta: float) -> State:
	return null
