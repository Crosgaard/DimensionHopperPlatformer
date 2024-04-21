class_name LevelParent extends Node2D

@onready var tileMap: TileMap = $TileMap

func enter_dimension() -> void:
	visible = true
	%ParallaxBackground.visible = true
	tileMap.set_layer_enabled(1, true)
	for child in $KillAreas.get_children():
		if "set_disabled" in child:
			child.set_disabled(false)

func exit_dimension() -> void:
	visible = false
	%ParallaxBackground.visible = false
	tileMap.set_layer_enabled(1, false)
	for child in $KillAreas.get_children():
		if "set_disabled" in child:
			child.set_disabled(true)
