extends Area2D

@export var difficulty: int = 1

# Colors
var yellow = Color(1., 1., 0.2)
var red  = Color(1., 0.2, 0.4)
var purple = Color(0.6, 0.4, 1.)

@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	var color: Color
	match difficulty:
		1:
			color = yellow
		2:
			color = red
		3:
			color = purple
	sprite.modulate = color
	$PointLight2D.color = color

func _on_body_entered(body):
	if body is Player:
		body.collected()

func _on_area_entered(area):
	if area is KillBarrier:
		queue_free()
