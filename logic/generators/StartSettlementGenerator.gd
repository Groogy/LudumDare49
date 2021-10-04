extends "SettlementGenerator.gd"

func generate() -> void:
	var parent := get_parent()
	var entities = parent.get_entities()
	var terrain = parent.get_terrain_map()
	var water = parent.get_water_map()
	var spot = null
	var highest_water := 0
	for x in range(terrain.map_bounds.position.x, terrain.map_bounds.size.x):
		var surface: int = terrain.find_surface(x)
		var level: int = water.find_water_surface(x)
		if level < highest_water: highest_water = level
		if surface < highest_water:
			spot = find_empty_spot(3, x, x+10)
			if spot != Vector2(0, 0):
				break
	start_x = spot.x
	start_y = spot.y
	for x in parent.start_settlement_max_size-1:
		wanted_parts.push_back("urban")
	wanted_parts.push_back("market")
	wanted_parts.shuffle()
	build_entity(entities, terrain)
