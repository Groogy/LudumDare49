tool
extends TileMap


const FULL_WATER_TILE_ID = 16


export var inject_water_pos := Vector2()
export var intensity := 1.0

var map_bounds = Rect2()


func _draw():
	if Engine.editor_hint:
		draw_circle(map_to_world(inject_water_pos) + cell_size / 2, cell_size.x / 2, Color.aqua)


func has_water(x: int, y: int) -> bool:
	return get_water_level_at(x, y) > 0


func get_water_level_at(x: int, y: int) -> int:
	var id := get_cell(x, y)
	var level := _convert_id_to_water_level(id)
	return level


func set_water_level_at(x: int, y: int, level: int) -> void:
	assert(level >= 0)
	if level > Const.MAX_WATER_LEVEL:
		var leftover = level - Const.MAX_WATER_LEVEL
		add_water_level_at(x, y-1, leftover)
		level = Const.MAX_WATER_LEVEL
	var id := _convert_water_level_to_id(level, x, y)
	set_cell(x, y, id)
	if level > 0 and get_water_level_at(x, y+1) == Const.MAX_WATER_LEVEL:
		set_cell(x, y+1, FULL_WATER_TILE_ID)


func add_water_level_at(x: int, y: int, val: int) -> void:
	var level := get_water_level_at(x, y)
	set_water_level_at(x, y, level + val)


func find_water_surface(x: int) -> int:
	for y in range(-map_bounds.end.y, -map_bounds.position.y):
		if get_water_level_at(x, y) > 0:
			return y
	return -int(map_bounds.position.y) # There's a gaping hole in the map?


func _convert_id_to_water_level(id: int) -> int:
	id += 1
	if id > Const.MAX_WATER_LEVEL: 
		id = Const.MAX_WATER_LEVEL
	return id


func _convert_water_level_to_id(level: int, x: int, y: int) -> int:
	if level == Const.MAX_WATER_LEVEL and has_water(x, y-1): # Check if we are not the surface
		return FULL_WATER_TILE_ID
	else:
		return level-1
		
