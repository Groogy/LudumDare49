extends Node2D


var cell_under_mouse := Vector2(0, 0)

var _valid_last_render := false


func _process(_delta: float) -> void:
	cell_under_mouse = Root.map_manager.world_to_map(get_global_mouse_position())
	global_position = Root.map_manager.map_to_world(cell_under_mouse) # Snap to grid
	if _needs_redraw():
		update()


func _draw() -> void:
	_valid_last_render = Root.map_manager.can_build_dyke(cell_under_mouse)
	
	var color := Color.green
	if not _valid_last_render:
		color = Color.red
	draw_rect(Rect2(Vector2(0, 0), Vector2(16, 16)), color, false, 1.5, true)


func _needs_redraw() -> bool:
	return _valid_last_render != Root.map_manager.can_build_dyke(cell_under_mouse)
