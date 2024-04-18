class_name LevelParent extends Node2D

@onready var tileMap: TileMap = $TileMap

func enter_dimension() -> void:
	visible = true
	%ParallaxBackground.visible = true
	tileMap.set_layer_enabled(0, true)

func exit_dimension() -> void:
	visible = false
	%ParallaxBackground.visible = false
	tileMap.set_layer_enabled(0, false)
