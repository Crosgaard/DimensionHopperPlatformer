class_name Player extends CharacterBody2D

@export var camera_offset: float = 1000.0

var max_jump: int = 1
var current_jump: int = 0
var has_dashed: bool = false
var collected_counter: int = 0

@onready var animator: AnimationPlayer = $AnimationPlayerD1
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: Node = $StateMachine
@onready var player_move_component = $PlayerMoveComponent

@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	animator.connect("animation_finished", on_animation_finished)
	state_machine.init(self, animator, sprite, player_move_component)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
	# Camera offset
	camera.position.x = position.x
	print(velocity.x)
	if velocity.x > 1:
		camera.position.x += camera_offset
	elif velocity.x < -1:
		camera.position.x -= camera_offset

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func on_animation_finished(anim_name: String) -> void:
	state_machine.on_animation_finished(anim_name)

func die() -> void:
	print("Has died")
	reset_collected()

func collected() -> void:
	print("Has collected")
	collected_counter += 1

func reset_collected() -> void:
	collected_counter = 0
