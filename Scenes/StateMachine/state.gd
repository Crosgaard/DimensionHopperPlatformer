class_name State
extends Node

@export var animation_name: String

@export var move_speed: float = 250.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var animations: AnimationPlayer
var move_component
var parent: CharacterBody2D

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

