class_name AreaQTE extends Area2D

@export var input_action: String
@export var duration: float = 0.3

var QTE = QuickTimeEvent.new()
var player: Player
var has_activated: bool = false

@onready var HBox: HBoxContainer = $HBoxContainer

func _ready() -> void:
	add_child(QTE)
	
	QTE.input_action = input_action
	QTE.duration = duration
	QTE.input_successful.connect(qte_successful)
	QTE.input_failed.connect(qte_failed)
	HBox.visible = false

func _process(delta: float) -> void:
	if QTE.active and player:
		HBox.position.x = player.position.x - HBox.size.x / 2 * HBox.scale.x
		HBox.position.y = player.position.y - 200

func qte_successful() -> void:
	has_activated = true
	HBox.visible = false

func qte_failed() -> void:
	if player:
		player.die()
	HBox.visible = false

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Player and not has_activated:
		player = body
		QTE.start()
		HBox.visible = true

