tool
extends Node2D


const UrbanSettlementScene = preload("res://scenes/UrbanSettlementPart.tscn")


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
	var spot = find_empty_spot()
	var parts = build_start_settlement_parts(spot)
	var entity: Entity = entities.create_entity(parts)
	pass


func build_start_settlement_parts(spot) -> Array:
	var parent := get_parent()
	var parts = []
	for x in parent.start_settlement_max_size:
		if not can_place_on(spot.x + x, spot.y): break
		var part = UrbanSettlementScene.instance()
		part.cell_x = spot.x + x
		part.cell_y = spot.y
		parts.push_back(part)
	return parts

func find_empty_spot() -> Vector2:
	var parent := get_parent()
	var terrain = parent.get_terrain_map()
	var entities = parent.get_entities()
	var is_empty := false
	var x: int = 0
	var y: int = 0
	while not is_empty:
		x = parent.start_settlement_area.position.x + randi() % int(parent.start_settlement_area.size.x)
		y = terrain.find_surface(x)-1
		is_empty = can_place_on(x, y)
	return Vector2(x, y)
	
func can_place_on(x: int, y: int) -> bool:
	var parent := get_parent()
	var terrain = parent.get_terrain_map()
	var entities = parent.get_entities()
	return entities.is_empty(x, y) and terrain.is_empty(x, y) and terrain.is_filled(x, y+1)
