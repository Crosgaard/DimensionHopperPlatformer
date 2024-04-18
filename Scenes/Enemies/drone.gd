extends Entity

@onready var immobile_move_component = $ImmobileMoveComponent

func _ready() -> void:
	animator.connect("animation_finished", on_animation_finished)
	state_machine.init(self, animator, sprite, immobile_move_component)

