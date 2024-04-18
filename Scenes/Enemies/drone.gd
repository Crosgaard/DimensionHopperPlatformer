extends CharacterBody2D

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: Node = $StateMachine
@onready var immobile_move_component = $ImmobileMoveComponent

func _ready() -> void:
	animator.connect("animation_finished", on_animation_finished)
	state_machine.init(self, animator, sprite, immobile_move_component)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func on_animation_finished(anim_name: String) -> void:
	state_machine.on_animation_finished(anim_name)


