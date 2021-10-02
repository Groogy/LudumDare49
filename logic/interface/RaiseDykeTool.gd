extends Node2D

func _process(_delta: float) -> void:
	global_position = Root.map_manager.snap_to_grid(get_global_mouse_position())


func _draw() -> void:
	draw_rect(Rect2(Vector2(0, 0), Vector2(16, 16)), Color.red, false, 1.5, true)

