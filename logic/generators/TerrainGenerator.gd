tool
extends Node2D


func _draw() -> void:
	var parent := get_parent()
	if Engine.editor_hint:
		var map: TileMap = parent.get_terrain_map()
		if not map: return
		var start = map.map_to_world(parent.target_area.position)
		var end = map.map_to_world(parent.target_area.end * Vector2(1, -1))
		draw_rect(Rect2(start, end-start), Color.blueviolet, false, 2.0, false)


func generate_terrain() -> void:
	var parent := get_parent()
	var map: TileMap = parent.get_terrain_map()
	if not map: return
	map.clear()
	map.map_bounds = parent.target_area
	for i in 32:
		for x in range(parent.target_area.position.x, parent.target_area.end.x):
			map.fill(x) #Set a level playing field

