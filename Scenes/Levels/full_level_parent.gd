class_name FullLevelParent extends Node2D

signal changedDimension

@export var next_scene: String
@export var level_id: int

@onready var dimension_1: LevelParent = $Dimension1
@onready var dimension_2: LevelParent = $Dimension2
@onready var dimensions = [dimension_1, dimension_2]
@onready var player: Player = $Player
@onready var current_dimension: LevelParent = dimension_1
@onready var kill_barrier: KillBarrier = $KillBarrier
@onready var timer: CanvasLayer = $Timer
@onready var pause_menu: CanvasLayer = $PauseMenu
@onready var username_menu: CanvasLayer = $PickUsername

var changing_level: bool = false

func _ready():
	dimension_1.enter_dimension()
	dimension_2.exit_dimension()
	for child in $Obtainables.get_children():
		child.set_is_monitoring()
	pause_menu.setResume()
	if Database.username == "":
		username_menu.connect("username_update", username_update)
	else:
		var leaderboard = await(get_top_times(level_id, 5))
		pause_menu.set_leaderboard_data(leaderboard, Database.username, await(get_time(level_id)));
	
		

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_menu.game_paused()
	
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
		changing_level = true
		save_time()
		var record = await(get_time(level_id))
		pause_menu.set_leaderboard_data(await(get_top_times(level_id, 5)), Database.username, record)
		pause_menu.setNextLevel()
		pause_game()

func save_time():
	timer.save_time(level_id)

func username_update(username: String) -> void:
	Database.username = username
	pause_menu.set_leaderboard_data(await(get_top_times(level_id, 5)), Database.username, await(get_time(level_id)));
	username_menu.visible = false

func pause_game():
	pause_menu.game_paused()

func resume():
	if changing_level:
		changing_level = false
		TransitionLayer.change_scene(next_scene)

func restart():
	player.die()

func get_top_times(level_id: int, amount: int):
	var leaderboard = await(timer.get_top_records(level_id, amount))
	print(leaderboard)
	return leaderboard
	
func get_time(level_id: int):
	return await(timer.get_record(level_id))

func start_timer():
	timer.start()

func stop_timer():
	timer.stop()

func reset_timer():
	timer.reset()
