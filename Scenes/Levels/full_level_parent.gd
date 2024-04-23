class_name FullLevelParent extends Node2D

signal changedDimension

@export var next_scene: String

@onready var dimension_1: LevelParent = $Dimension1
@onready var dimension_2: LevelParent = $Dimension2
@onready var dimensions = [dimension_1, dimension_2]
@onready var player: Player = $Player
@onready var current_dimension: LevelParent = dimension_1
@onready var kill_barrier: KillBarrier = $KillBarrier
@onready var timer: CanvasLayer = $Timer

func _ready():
	dimension_1.enter_dimension()
	dimension_2.exit_dimension()
	for child in $Obtainables.get_children():
		child.set_is_monitoring()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dimension_shift"):
		match current_dimension:
			dimension_1:
				change_dimension(dimension_2)
			dimension_2:
				change_dimension(dimension_1)

func change_dimension(new_dimension: LevelParent) -> void:
	changedDimension.emit()
	current_dimension.exit_dimension()
	current_dimension = new_dimension
	current_dimension.enter_dimension()

func player_dead() -> void:
	reset_kill_barrier()
	for child in $Obtainables.get_children():
		child.set_is_monitoring()

func restart_kill_barrier() -> void:
	kill_barrier.restart()

func reset_kill_barrier() -> void:
	kill_barrier.reset()

func get_player() -> Player:
	return player

func _on_lower_kill_barrier_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		body.die()

func _on_end_area_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		TransitionLayer.change_scene(next_scene)

func save_time():
	timer.save_time(1, "Din Far")

func get_top_times():
	print(await(timer.get_top_records(0, 5)))

func start_timer():
	timer.start()

func stop_timer():
	timer.stop()

func reset_timer():
	timer.reset()
