class_name QuickTimeEvent extends Node

var active: bool
var duration: float
var time_scale: float = 0.2
var input_action: String

signal input_successful
signal input_failed

func _input(event):
	if active and event.is_action_pressed(input_action):
		end(true)

func start() -> void:
	var timer = get_tree().create_timer(duration)
	timer.timeout.connect(end)
	active = true
	Engine.time_scale = time_scale

func end(successful: bool = false) -> void:
	if active:
		active = false
		Engine.time_scale = 1
		if successful:
			input_successful.emit()
		else:
			input_failed.emit()
