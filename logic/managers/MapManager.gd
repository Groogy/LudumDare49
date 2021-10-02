extends Node2D

onready var water = $WaterMap
onready var terrain = $TerrainMap
onready var entities = $EntityManager


# Queries
func is_within_bounds(x: int, y: int) -> bool:
	return terrain.bounds.has_point(Vector2(x, -y))


func is_empty(x: int, y: int, include_partial: bool = true) -> bool:
	return is_within_bounds(x, y) \
		and (terrain.is_empty(x, y) or (not include_partial and terrain.is_partial(x, y))) \
		and water.get_water_level_at(x, y) <= 0 \
		and entities.is_empty(x, y)


func can_have_more_water(x: int, y: int) -> bool:
	return 	is_within_bounds(x, y) \
		and (terrain.is_empty(x, y) or terrain.is_partial(x, y)) \
		and water.get_water_level_at(x, y) < water.get_max_water_level() \
		and not entities.is_water_blocked(x, y)


# Conversion
func map_to_world(cell: Vector2) -> Vector2:
	return terrain.map_to_world(cell)


func world_to_map(pos: Vector2) -> Vector2:
	return terrain.world_to_map(pos)


func snap_to_grid(pos: Vector2) -> Vector2:
	return terrain.map_to_world(terrain.world_to_map(pos))


# Modification
func fill_terrain_cell(cell: Vector2) -> void:
	terrain.fill(cell.x)


func empty_terrain_cell(cell: Vector2) -> void:
	terrain.empty(cell.x)
