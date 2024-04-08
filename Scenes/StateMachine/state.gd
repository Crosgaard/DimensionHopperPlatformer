class_name State extends Node

@export var animation_name: String

@export var move_speed: float = 450.0

@export var accel: float = 10

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var animator: AnimationPlayer
var sprite: Sprite2D
var move_component
var parent: CharacterBody2D
var prev_state: State

func enter() -> void:
	pass

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

func get_dash() -> bool:
	return move_component.wants_dash()

func can_dash() -> bool:
	return not parent.has_dashed

func set_has_dashed(value: bool) -> void:
	parent.has_dashed = value
