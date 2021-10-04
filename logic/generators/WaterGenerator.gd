extends Node2D

func generate() -> void:
	var terrain = get_parent().get_terrain_map()
	var water = get_parent().get_water_map()
	var entities = get_parent().get_entities()
	var highest_peak = terrain.find_peak()
	water.inject_water_pos.y = highest_peak + 4
	var water_level: int = water.inject_water_pos.y
	for x in range(terrain.map_bounds.position.x, terrain.map_bounds.end.x):
		var surface: int = terrain.find_surface(x)
		if surface <= water_level+1: break
		for y in range(surface, water_level, -1):
			water.set_water_level_at(x, y, Const.MAX_WATER_LEVEL)
