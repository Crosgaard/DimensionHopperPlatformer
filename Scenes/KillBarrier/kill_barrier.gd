extends Area2D

@export var start_point: Vector2
@export var end_point: Vector2
@export var time: float

func _ready():
	position = start_point
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", end_point, time)

func _on_body_entered(body):
	if body is Player:
		body.die()
