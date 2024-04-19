extends CanvasLayer

var current_time: float

var counting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_time += delta * 1000
	
func reset():
	current_time = 0

func start():
	counting = true
