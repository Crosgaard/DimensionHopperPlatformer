extends State
@export var idle_state: State
@export var return_state: State
@export var shoot_state: State
@export var out_of_dimension_state: State

@export var follow_speed: float

var last_seen_player: float = 0

func enter() -> void:
	last_seen_player = Time.get_ticks_msec()

func process_physics(delta: float) -> State:
	var space_state = get_viewport().get_world_2d().direct_space_state
	var player = parent.full_level_parent.get_player()
	var query = PhysicsRayQueryParameters2D.create(parent.position, player.position)
	var result = space_state.intersect_ray(query)
	
	if result == {}: 
		return null
		
	if result.collider != parent.full_level_parent.get_player():
		if Time.get_ticks_msec() - last_seen_player > 2000:
			return return_state
	else:
		last_seen_player = Time.get_ticks_msec()
		var movement = parent.full_level_parent.get_player().position - parent.position
		if movement:
			parent.position = parent.position + movement / movement.length() * follow_speed
	return null

func process_frame(delta: float) -> State:
	return null
