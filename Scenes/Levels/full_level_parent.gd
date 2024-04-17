extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dimension_shift"):
		$Dimension1.tileMap.tile_set.set_physics_layer_collision_layer(0,1)
		print($Dimension1.tileMap.tile_set.get_physics_layer_collision_layer(0))
