class_name FullLevelParent extends Node2D

signal changedDimension

@onready var dimension_1: LevelParent = $Dimension1
@onready var dimension_2: LevelParent = $Dimension2
@onready var dimensions = [dimension_1, dimension_2]
@onready var player: Player = $Player

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dimension_shift"):
		$Dimension1.tileMap.tile_set.set_physics_layer_collision_layer(0,1)
		print($Dimension1.tileMap.tile_set.get_physics_layer_collision_layer(0))

func get_player() -> Player:
	return self.player
