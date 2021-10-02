tool
extends TileMap


const MAX_WATER_LEVEL = 16
const FULL_WATER_TILE_ID = 16


export var inject_water_pos := Vector2()


func _draw():
	if Engine.editor_hint:
		draw_circle(map_to_world(inject_water_pos) + cell_size / 2, cell_size.x / 2, Color.aqua)


func get_max_water_level() -> int:
	return MAX_WATER_LEVEL


func has_water(x: int, y: int) -> bool:
	return get_water_level_at(x, y) > 0


func get_water_level_at(x: int, y: int) -> int:
	var id := get_cell(x, y)
	var level := _convert_id_to_water_level(id)
	return level


func set_water_level_at(x: int, y: int, level: int) -> void:
	assert(level >= 0)
	if level > MAX_WATER_LEVEL:
		var leftover = level - MAX_WATER_LEVEL
		add_water_level_at(x, y-1, leftover)
		level = MAX_WATER_LEVEL
	var id := _convert_water_level_to_id(level, x, y)
	set_cell(x, y, id)


func add_water_level_at(x: int, y: int, val: int) -> void:
	var level := get_water_level_at(x, y)
	set_water_level_at(x, y, level + val)


func _convert_id_to_water_level(id: int) -> int:
	id += 1
	if id > MAX_WATER_LEVEL: 
		id = MAX_WATER_LEVEL
	return id


func _convert_water_level_to_id(level: int, x: int, y: int) -> int:
	if level == MAX_WATER_LEVEL and has_water(x, y-1): # Check if we are not the surface
		return FULL_WATER_TILE_ID
	else:
		return level-1
