extends CanvasLayer

signal username_update(username: String)

@onready var line_edit: LineEdit = $LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	if line_edit.text.length() < 4:
		line_edit.text = ""
		line_edit.placeholder_text = "Username length must be at least 4"
		return
	
	if line_edit.text.length() > 15:
		line_edit.text = ""
		line_edit.placeholder_text = "Username length must be less than 15"
		return
		
	username_update.emit(line_edit.text)
