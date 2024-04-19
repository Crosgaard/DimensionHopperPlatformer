class_name PlayerCamera extends Camera2D

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var shake_strength: Vector2 = Vector2(0.0, 0.0)
var camera_shaking: bool = false

var shake_dir_x: bool
var shakeFade: float

func _process(delta: float) -> void:
	if (shake_strength.x > 1 or shake_strength.x < -1) or (shake_strength.y > 1 or shake_strength.y < -1):
		shake_strength.x = lerpf(shake_strength.x, 0, shakeFade * delta)
		shake_strength.y = lerpf(shake_strength.y, 0, shakeFade * delta)
		
		if shake_dir_x:
			offset = random_offset_x()
		else:
			offset = random_offset_y()
	else:
		shake_strength = Vector2.ZERO
		camera_shaking = false

func apply_shake(shake_strength_x: float, shake_strength_y: float, shakeFade: float, shake_dir_x: bool = true) -> void:
	self.shake_strength.x = shake_strength_x
	self.shake_strength.y = shake_strength_y
	self.shakeFade = shakeFade
	self.shake_dir_x = shake_dir_x
	camera_shaking = true

func random_offset_x() -> Vector2:
	return Vector2(rng.randf_range(0.0, shake_strength.x), rng.randf_range(-shake_strength.y, shake_strength.y))

func random_offset_y() -> Vector2:
	return Vector2(rng.randf_range(shake_strength.x, shake_strength.x), rng.randf_range(0.0, shake_strength.y))
