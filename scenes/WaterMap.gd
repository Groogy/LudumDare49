extends TileMap


const MAX_WATER_LEVEL = 15
const FULL_WATER_TILE_ID = 16

func has_water(x: int, y: int) -> bool:
	return get_water_level_at(x, y) > 0


func get_water_level_at(x: int, y: int) -> int:
	var id := get_cell(x, y)
	var level := _convert_id_to_water_level(id)
	return level


func set_water_level_at(x: int, y: int, level: int) -> void:
	assert(level > 0 and level <= MAX_WATER_LEVEL)
	var id := _convert_water_level_to_id(level, x, y)
	set_cell(x, y, id)

func _convert_id_to_water_level(id: int) -> int:
	if id > MAX_WATER_LEVEL: 
		id = MAX_WATER_LEVEL
	return id

func _convert_water_level_to_id(level: int, x: int, y: int) -> int:
	var id := level
	if id == MAX_WATER_LEVEL and has_water(x, y-1): # Check if we are not the surface
		id = FULL_WATER_TILE_ID
	return id
