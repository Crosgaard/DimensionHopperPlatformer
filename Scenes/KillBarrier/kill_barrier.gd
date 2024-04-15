extends Area2D

@export var time: float

var direction: Vector2
var distance: Vector2

@onready var start_point: Vector2 = %StartPoint.global_position
@onready var end_point: Vector2 = %EndPoint.global_position

func _ready() -> void:
	
