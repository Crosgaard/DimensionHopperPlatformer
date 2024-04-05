class_name Player extends CharacterBody2D

@onready var animations: AnimatedSprite2D = $animations
@onready var state_machine: Node = $state_machine
@onready var move_component = $player_move_component

func _ready() -> void:
	state_machine.init(self, animations, player_move_component)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
