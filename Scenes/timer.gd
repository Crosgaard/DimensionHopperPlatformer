extends CanvasLayer

@onready var db = $DBClient
@onready var label = $MarginContainer/Label

var current_time: float

var counting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if counting:
		current_time += delta * 1000
	
	var minutes = floori(current_time / 1000 / 60)
	var seconds = floori((current_time - minutes * 60 * 1000) / 1000)
	var millis = floori(current_time - minutes * 60 * 1000 - seconds * 1000.0)
	var formatted = ""
	if minutes < 10:
		formatted += "0"
	formatted += str(minutes) + ":"
	if seconds < 10:
		formatted += "0"
	formatted += str(seconds) + "."
	if millis < 100:
		formatted += "0"
	if millis < 10:
		formatted += "0"
	formatted += str(millis)
	
	label.text = formatted

func save_time(level_id: int):
	pass

func reset():
	current_time = 0

func start():
	counting = true

func stop():
	counting = false

func is_counting():
	return counting
