extends Node2D

@onready var dimension_1: LevelParent = $Dimension1
@onready var dimension_2: LevelParent = $Dimension2
@onready var current_dimension: LevelParent = dimension_1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dimension_shift"):
		match current_dimension:
			dimension_1:
				change_dimension(dimension_2)
			dimension_2:
				change_dimension(dimension_1)

func change_dimension(new_dimension: LevelParent) -> void:
	current_dimension.exit_dimension()
	current_dimension = new_dimension
	current_dimension.enter_dimension()
