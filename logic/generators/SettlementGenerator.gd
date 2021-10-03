extends Node2D


const SettlementUrbanScene = preload("res://scenes/entities/SettlementUrbanPart.tscn")
const SettlementNameScene = preload("res://scenes/entities/SettlementName.tscn")

const PartsLookup = {
	"urban": SettlementUrbanScene
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
