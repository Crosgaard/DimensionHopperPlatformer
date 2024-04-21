extends KillArea

@onready var collision: CollisionShape2D = $CollisionShape2D

func set_disabled(disabled: bool) -> void:
	monitoring = not disabled

func _on_body_entered(body):
	super(body)
