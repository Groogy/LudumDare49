extends "BuildToolNode.gd"


var _can_build_last_frame := false


func _draw() -> void:
	_can_build_last_frame = Root.construction_manager.can_dig_channel(cell_under_mouse)
	
	var color := Color.green
	if not _can_build_last_frame:
		color = Color.red
	draw_rect(Rect2(Vector2(0, 0), Vector2(16, 16)), color, false, 1.5, true)


func can_build() -> bool:
	return _can_build_last_frame


func build() -> void:
	Root.construction_manager.dig_channel(cell_under_mouse)


func _needs_redraw() -> bool:
	return _can_build_last_frame != Root.construction_manager.can_dig_channel(cell_under_mouse)
