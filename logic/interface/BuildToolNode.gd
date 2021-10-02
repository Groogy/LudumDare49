extends Node2D

var cell_under_mouse := Vector2(0, 0)

func _ready() -> void:
	_update_mouse_position()
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_update_mouse_position()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_select") and can_build():
		build()
		get_tree().set_input_as_handled()


func can_build() -> bool:
	return false


func build() -> void:
	pass


func _update_mouse_position() -> void:
	cell_under_mouse = Root.map_manager.world_to_map(get_global_mouse_position())
	global_position = Root.map_manager.map_to_world(cell_under_mouse) # Snap to grid
	if _needs_redraw():
		update()


func _needs_redraw() -> bool:
	return false # Please override
