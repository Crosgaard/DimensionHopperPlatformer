class_name Entity extends CharacterBody2D

@export var full_level_parent: FullLevelParent:
	set(value):
		full_level_parent = value
		if value:
			full_level_parent.connect("changedDimension", dimension_changed)

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: Node = $StateMachine

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func on_animation_finished(anim_name: String) -> void:
	state_machine.on_animation_finished(anim_name)

func dimension_changed():
	state_machine.toggle_dimension()
