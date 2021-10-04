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


func generate() -> void:
	var parent := get_parent()
	var map: TileMap = parent.get_terrain_map()
	var water: TileMap = parent.get_water_map()
	if not map: return
	map.map_bounds = parent.target_area
	water.map_bounds = parent.target_area
	var current_y = parent.start_y
	var prevous_y = current_y
	var min_y = parent.start_y
	var count := 2
	var highest = 0
	var levels := []
	for x in range(parent.target_area.position.x, parent.target_area.end.x):
		levels.append(current_y)
		if current_y > highest: highest = current_y
		if count <= 0 and (x > 64 and current_y < 18) or randi() % 2 == 0: # Should we change level?
			if randi() % 2 == 0:
				current_y = max(current_y + randi() % 3 - 1, min_y)
			else:
				current_y = current_y + randi() % 2
			count = 2
		else:
			count -= 1
	
	for y in highest:
		for x in range(parent.target_area.position.x, parent.target_area.end.x): 
			if -map.find_surface(x) < levels[x]:
				map.fill(x)

