extends CanvasLayer

var db_client: DBClient = DBClient.new()
@onready var label: Label = $MarginContainer/Label

var current_time: float
var counting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(db_client)
	reset()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if counting:
		current_time += delta * 1000
	
	var formatted_time = format_time(current_time)
	
	label.text = formatted_time

func save_time(level_id: int, username: String) -> void:
	stop()
	db_client.add_record(level_id, username, format_time(current_time))

func get_top_records(level_id: int, amount: int):
	return await(db_client.get_top_records(level_id, amount))
	

func format_time(time: float) -> String:
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
	return formatted

func reset() -> void:
	current_time = 0

func start() -> void:
	counting = true

func stop() -> void:
	counting = false

func is_counting() -> bool:
	return counting
