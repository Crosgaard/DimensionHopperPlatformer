extends CharacterBody2D

@export var player: Player

@onready var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	scale = player.scale

func _physics_process(delta: float) -> void:
	if not is_on_floor() and player.velocity.y >= 0:
		velocity.y += gravity * delta
	elif not (player.is_on_floor() and not is_on_floor()):
		velocity.y = player.velocity.y
	velocity.x = player.velocity.x
	move_and_slide()
