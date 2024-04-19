extends State


@export var idle_state: State
@export var return_state: State
@export var shoot_state: State
@export var out_of_dimension_state: State

@export var follow_speed: float
@export var range: float

var last_seen_player: float = 0

func enter() -> void:
	last_seen_player = Time.get_ticks_msec()

func process_physics(delta: float) -> State:
	var player = parent.full_level_parent.get_player()
	var result = player.line_of_site_cast(parent.position, player.position)
		
	if result.collider != parent.full_level_parent.get_player():
		if Time.get_ticks_msec() - last_seen_player > 2000:
			return return_state
	else:
		last_seen_player = Time.get_ticks_msec()
		var dist = parent.full_level_parent.get_player().position - parent.position
		if dist.length() < range:
			return shoot_state
		
		if dist:
			parent.position = parent.position + dist / dist.length() * follow_speed
	return null

func process_frame(delta: float) -> State:
	return null
