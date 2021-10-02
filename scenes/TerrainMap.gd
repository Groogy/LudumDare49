extends TileMap


const SURFACE_TILE_ID = 1
const UNDERGROUND_TILE_ID = 0
const PARTIAL_TILE_ID = [2, 3]

var bounds := Rect2(0, 0, 0, 0)


func is_empty(x: int, y: int) -> bool:
	return get_cell(x, y) == -1


func is_partial(x: int, y: int) -> bool:
	return PARTIAL_TILE_ID.has(get_cell(x, y))


func fill(x: int) -> void:
	var surface = find_surface(x)
	set_cell(x, surface, UNDERGROUND_TILE_ID)
	set_cell(x, surface - 1, SURFACE_TILE_ID)


func find_surface(x: int) -> int:
	for y in range(-bounds.end.y, -bounds.position.y):
		var cell := get_cell(x, y)
		if cell != -1:
			return y
	return -int(bounds.position.y) # There's a gaping hole in the map?

func get_full_tile_id() -> int:
	return UNDERGROUND_TILE_ID

func get_surface_tile_id() -> int:
	return SURFACE_TILE_ID
