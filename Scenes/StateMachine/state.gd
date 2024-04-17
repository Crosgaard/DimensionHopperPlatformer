class_name State extends Node

@export var animation_name: String
@export_category("Movement")
@export var max_move_speed: float = 550.0
@export var accel: float = 20
@export var standard_floor_friction: float = 3.0
@export var jump_buffer: float = 0.075

var jump_buffer_timer: float = 0.0
var bunny_hop: float = 0.03
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var tolerance: float = 30

var animator: AnimationPlayer
var sprite: Sprite2D
var move_component: MoveComponentInterface
var parent: CharacterBody2D
var prev_state: State

@onready var floor_friction: float = standard_floor_friction

func enter() -> void:
	if animation_name:
		animator.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func on_animation_finished(anim_name: String) -> void:
	pass

func get_movement_input() -> float:
	return move_component.get_movement_direction()

func get_jump() -> bool:
	return move_component.wants_jump()

func set_jump() -> void:
	parent.current_jump += 1

func reset_jump() -> void:
	parent.current_jump = 0

func get_can_jump() -> bool:
	return parent.current_jump < parent.max_jump

func get_direction() -> float:
	if sprite.flip_h:
		return -1
	else:
		return 1

func get_dash() -> bool:
	return move_component.wants_dash()

func can_dash() -> bool:
	return not parent.has_dashed

func set_has_dashed(value: bool) -> void:
	parent.has_dashed = value
