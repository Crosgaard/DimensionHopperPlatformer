extends AreaQTE

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Player and not has_activated:
		player = body
		player.max_jump = 1
		QTE.start()
		$HBoxContainer.visible = true
