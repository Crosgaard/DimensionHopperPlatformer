class_name FullLevelParent extends Node2D

signal changedDimension

@onready var dimension_1: LevelParent = $Dimension1
@onready var dimension_2: LevelParent = $Dimension2
@onready var dimensions = [dimension_1, dimension_2]
@onready var player: Player = $Player
@onready var current_dimension: LevelParent = dimension_1

func _ready():
	dimension_1.enter_dimension()
	dimension_2.exit_dimension()

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
