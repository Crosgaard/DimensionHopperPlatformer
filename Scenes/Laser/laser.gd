extends KillArea

@onready var collision: CollisionShape2D = $CollisionShape2D

func set_disabled(disabled: bool) -> void:
	set_deferred("monitoring", not disabled)

func _on_body_entered(body: CharacterBody2D) -> void:
	super(body)
