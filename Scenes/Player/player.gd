class_name Player extends CharacterBody2D

@export var camera_offset: float = 850.0
@export var full_level_parent: FullLevelParent

var max_jump: int = 1
var current_jump: int = 0
var has_dashed: bool = false
var collected_counter: int = 0

@onready var animator_d1: AnimationPlayer = $AnimationPlayerD1
@onready var animator_d2: AnimationPlayer = $AnimationPlayerD2
@onready var current_animator: AnimationPlayer = animator_d1
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: Node = $StateMachine
@onready var player_move_component = $PlayerMoveComponent

@onready var camera: Camera2D = $Camera2D
@onready var start_pos: Vector2 = position

func _ready() -> void:
	animator_d1.connect("animation_finished", on_animation_finished)
	animator_d2.connect("animation_finished", on_animation_finished)
	full_level_parent.connect("changedDimension", changed_dimension)
	state_machine.init(self, current_animator, sprite, player_move_component)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
	# Camera offset
	camera.position.x = position.x
	if sprite.flip_h:
		camera.position.x -= camera_offset
	else:
		camera.position.x += camera_offset

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func on_animation_finished(anim_name: String) -> void:
	state_machine.on_animation_finished(anim_name)

func changed_dimension() -> void:
	current_animator = animator_d1 if current_animator == animator_d2 else animator_d2
	state_machine.set_animator(current_animator)
	print(current_animator)

func die() -> void:
	print("Has died")
	reset_collected()

func collected() -> void:
	print("Has collected")
	collected_counter += 1

func reset_collected() -> void:
	collected_counter = 0
