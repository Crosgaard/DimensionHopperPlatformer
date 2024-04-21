class_name AreaQTE extends Area2D

@export var input_action: String
@export var duration: float = 0.3

var QTE = QuickTimeEvent.new()
var player: Player
var has_activated: bool = false

func _ready() -> void:
	add_child(QTE)
	
	QTE.input_action = input_action
	QTE.duration = duration
	QTE.input_successful.connect(qte_successful)
	QTE.input_failed.connect(qte_failed)
	$HBoxContainer.visible = false

func _process(delta: float) -> void:
	if QTE.active and player:
		$HBoxContainer.position.x = player.position.x
		$HBoxContainer.position.y = player.position.y - 100

func qte_successful() -> void:
	has_activated = true
	$HBoxContainer.visible = false

func qte_failed() -> void:
	if player:
		player.die()
	$HBoxContainer.visible = false

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Player and not has_activated:
		player = body
		QTE.start()
		$HBoxContainer.visible = true

