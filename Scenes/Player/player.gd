class_name Player extends CharacterBody2D

var max_jump: int = 1
var current_jump: int = 0
var has_dashed: bool = false

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: Node = $StateMachine
@onready var player_move_component = $PlayerMoveComponent

func _ready() -> void:
	animator.connect("animation_finished", on_animation_finished)
	state_machine.init(self, animator, sprite, player_move_component)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func on_animation_finished(anim_name: String) -> void:
	state_machine.on_animation_finished(anim_name)
