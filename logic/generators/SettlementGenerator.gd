extends Node2D


const SettlementUrbanScene = preload("res://scenes/entities/SettlementUrbanPart.tscn")
const SettlementMarketScene = preload("res://scenes/entities/SettlementMarketPart.tscn")

const SettlementNameScene = preload("res://scenes/entities/SettlementName.tscn")
const SettlementGrowthScene = preload("res://scenes/entities/SettlementGrowth.tscn")

const PartsLookup = {
	"urban": SettlementUrbanScene,
	"market": SettlementMarketScene,
}

var wanted_parts = []
var start_x := 0
var start_y := 0


func build_entity(entities, terrain) -> Entity:
	var parts = build_wanted_parts(entities, terrain)
	parts.append_array(build_functional_parts())
	return entities.create_entity(parts)


func build_wanted_parts(entities, terrain) -> Array:
	var parts := []
	var current_x = start_x
	for wanted in wanted_parts:
		if not can_place_on(current_x, start_y):
			break
		var scene = PartsLookup[wanted]
		var part: EntityPart = scene.instance()
		part.cell_x = current_x
		part.cell_y = start_y
		current_x += 1
		parts.push_back(part)
	return parts


func build_functional_parts() -> Array:
	var parts := []
	var part = SettlementNameScene.instance()
	part.settlement_name = Names.generate_name()
	parts.push_back(part)
	part = SettlementGrowthScene.instance()
	parts.push_back(part)
	return parts


func find_good_spot(var clearence: int) -> Vector2:
	var other_settlements = get_parent().get_entities().fetch_all_parts_of("settlement_part")
	var map_bounds = get_parent().get_terrain_map()
	for try in 5: # Let's try and find a spot 5 times:
		var spot = find_empty_spot(clearence, map_bounds.position.x + randi() % int(map_bounds.size.x), 10)
		if spot != Vector2(0, 0):
			var nearest := 99999
			for other in other_settlements:
				if abs(spot.x - other.cell_x) > nearest:
					nearest = abs(spot.x - other.cell_x)
			if nearest > 16:
				return spot
	return Vector2(0, 0)


func find_empty_spot(var clearence: int, area_start: int, area_end: int) -> Vector2:
	var parent := get_parent()
	var terrain = parent.get_terrain_map()
	var entities = parent.get_entities()
	var is_empty := false
	var x: int = 0
	var y: int = 0
	var tries := 5
	while not is_empty and tries > 0:
		x = area_start + randi() % (area_end - area_start)
		y = terrain.find_surface(x)-1
		is_empty = true
		tries -= 1
		for i in clearence:
			is_empty = is_empty and can_place_on(x+i, y)
	if is_empty:
		return Vector2(x, y)
	else:
		return Vector2(0, 0)
	
func can_place_on(x: int, y: int) -> bool:
	return Root.map_manager.can_place_settlement_part_on(x, y)
