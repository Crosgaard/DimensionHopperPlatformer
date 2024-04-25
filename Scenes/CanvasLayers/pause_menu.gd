extends CanvasLayer

@export var parent: FullLevelParent

@onready var leaderboard: Label = $Control/Leaderboard
@onready var resume: Button = $Control/Resume
@onready var restart: Button = $Control/Restart

func set_leaderboard_data(data, local_player_name, local_player_time) -> void:
	var board: String = ""
	
	for i in range(5):
		if i >= data.size():
			board += "\n"
			continue
			
		var entry: String = str(i + 1) + "   " + data[i]["player_name"] + "   " + data[i]["record"]
		board += entry + "\n"
	
	board += "-    " + local_player_name + "   "
	if local_player_time == "":
		board += "N/A"
	else:
		board += local_player_time
	leaderboard.text = board

func setResume():
	resume.text = "Resume"

func setNextLevel():
	resume.text = "Next level"

func game_paused() -> void:
	get_tree().paused = true
	visible = true

func game_unpaused() -> void:
	get_tree().paused = false
	visible = false

func _on_resume_pressed():
	game_unpaused()
	parent.resume()

func _on_restart_pressed():
	game_unpaused()
	parent.restart()
