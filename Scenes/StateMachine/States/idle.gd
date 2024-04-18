extends State

@export var return_state: State
@export var target_state: State
@export var shoot_state: State
@export var out_of_dimension_state: State

func enter() -> void:
	pass

func process_physics(delta: float) -> State:
	var space_state = get_viewport().get_world_2d().direct_space_state
	var player = parent.full_level_parent.get_player()
	var query = PhysicsRayQueryParameters2D.create(parent.position, player.position)
	var result = space_state.intersect_ray(query)
	if result.collider == player:
		return null
		
	return null

func process_frame(delta: float) -> State:
	return null

