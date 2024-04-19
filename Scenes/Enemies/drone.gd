extends Entity

@onready var immobile_move_component = $ImmobileMoveComponent

var home_pos: Vector2 = position

func _ready() -> void:
	animator.connect("animation_finished", on_animation_finished)
	state_machine.init(self, animator, sprite, immobile_move_component)

func line_of_site_cast(pos0: Vector2, pos1: Vector2):
	var space_state = get_viewport().get_world_2d().direct_space_state
	var player = full_level_parent.get_player()
	var query = PhysicsRayQueryParameters2D.create(pos0, pos1)
	return space_state.intersect_ray(query)
