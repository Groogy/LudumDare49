extends Node2D

var cell_under_mouse := Vector2(0, 0)


var _can_build_last_frame := false


func _ready() -> void:
	if not visible: return
	_update_mouse_position()
	

func _input(event: InputEvent) -> void:
	if not visible: return
	if event is InputEventMouseMotion:
		_update_mouse_position()


func _draw() -> void:
	_can_build_last_frame = can_build()
	
	var color := Color.green
	if not _can_build_last_frame:
		color = Color.red
	draw_rect(Rect2(Vector2(0, 0), Vector2(16, 16)), color, false, 1.5, true)


func _unhandled_input(event: InputEvent) -> void:
	if not visible: return
	if event.is_action_pressed("game_select") and can_build():
		build()
		get_tree().set_input_as_handled()


func can_build() -> bool:
	return Root.resources.money >= get_money_cost()


func build() -> void:
	pass


func get_money_cost() -> float:
	return 0.0


func get_workers_cost() -> int:
	return 0


func generate_tooltip() -> String:
	if Root.resources.money < get_money_cost():
		return "Can't afford this!"
	elif not Root.map_manager.entities.is_empty(cell_under_mouse.x, cell_under_mouse.y):
		return "Already something in this tile"
	else:
		return ""


func _update_mouse_position() -> void:
	cell_under_mouse = Root.map_manager.world_to_map(get_global_mouse_position())
	global_position = Root.map_manager.map_to_world(cell_under_mouse) # Snap to grid
	if _needs_redraw():
		update()


func _needs_redraw() -> bool:
	return _can_build_last_frame() != can_build()


func _can_build_last_frame() -> bool:
	return _can_build_last_frame
