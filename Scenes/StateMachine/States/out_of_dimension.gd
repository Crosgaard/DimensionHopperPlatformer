extends State

func enter() -> void:
	pass

func process_physics(delta: float) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func toggle_dimension() -> State:
	return parent.state_machine.prev_state
