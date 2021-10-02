extends Node2D

onready var _water = $WaterMap
onready var _terrain = $TerrainMap


func is_within_bounds(x: int, y: int) -> bool:
	return x >= 0 and y <= 0 # TODO ADD UPPER BOUND


func is_empty(x: int, y: int) -> bool:
	return is_within_bounds(x, y) \
		and _terrain.get_cell(x, y) == -1 \
		and _water.get_cell(x, y) == -1

func can_have_more_water(x: int, y: int) -> bool:
	return 	is_within_bounds(x, y) \
		and (_terrain.is_empty(x, y) or _terrain.is_partial(x, y)) \
		and _water.get_water_level_at(x, y) < _water.get_max_water_level()
