tool
extends "SettlementGenerator.gd"

func _draw() -> void:
	if Engine.editor_hint:
		var parent := get_parent()
		var map: TileMap = parent.get_terrain_map()
		if not map: return
		var start = map.map_to_world(parent.start_settlement_area.position)
		var end = map.map_to_world(parent.start_settlement_area.end * Vector2(1, 1))
		draw_rect(Rect2(start, end-start), Color.red, false, 2.0, false)

func generate() -> void:
	if Engine.editor_hint: return
	var parent := get_parent()
	var entities = parent.get_entities()
	var terrain = parent.get_terrain_map()
	var spot = find_empty_spot()
	start_x = spot.x
	start_y = spot.y
	for x in parent.start_settlement_max_size:
		wanted_parts.push_back("urban")
	build_entity(entities, terrain)
