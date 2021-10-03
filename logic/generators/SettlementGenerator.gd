tool
extends Node2D

func _draw() -> void:
	if Engine.editor_hint:
		var parent := get_parent()
		var map: TileMap = parent.get_terrain_map()
		if not map: return
		var start = map.map_to_world(parent.start_settlement_area.position)
		var end = map.map_to_world(parent.start_settlement_area.end * Vector2(1, 1))
		draw_rect(Rect2(start, end-start), Color.red, false, 2.0, false)
