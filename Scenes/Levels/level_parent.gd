class_name LevelParent extends Node2D

@onready var tileMap: TileMap = $TileMap

func enter_dimension() -> void:
	tileMap.set_layer_enabled(0, true)

func exit_dimension() -> void:
	tileMap.set_layer_enabled(0, false)
