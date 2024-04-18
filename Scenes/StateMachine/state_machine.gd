extends Node

@export var starting_state: State

var current_state: State
var prev_state: State:
	set(value):
		prev_state = value
		current_state.prev_state = value

func init(parent: CharacterBody2D, animator: AnimationPlayer, sprite: Sprite2D, move_component) -> void:
	for child in get_children():
		child.parent = parent
		child.animator = animator
		child.sprite = sprite
		child.move_component = move_component
	
	change_state(starting_state)

func change_state(new_state: State) -> void:
	var this_state: State
	if current_state:
		this_state = current_state
		current_state.exit()
	
	current_state = new_state
	if this_state:
		prev_state = this_state
	current_state.enter()

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

func on_animation_finished(anim_name: String):
	current_state.on_animation_finished(anim_name)

func toggle_dimension():
	var new_state = current_state.toggle_dimension()
	if new_state:
		change_state(new_state)

func set_animator(animator: AnimationPlayer) -> void:
	for child in get_children():
		if child.animator.is_playing():
			var animation_pos: float = child.animator.current_animation_position
			var animation_name: String = child.animator.current_animation
			child.animator.stop()
			child.animator = animator
			child.animator.play(animation_name)
			child.animator.seek(animation_pos,true)
		else:
			child.animator = animator
