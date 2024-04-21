class_name KillBarrier extends KillArea

@export var start_point: Vector2
@export var end_point: Vector2
@export var time: float

var tween

func _ready():
	position = start_point

func _on_body_entered(body):
	super(body)

func reset() -> void:
	if tween:
		tween.kill()
	position = start_point

func restart() -> void:
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", end_point, time)
