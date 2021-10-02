extends TileMap


enum TileID {
	UNDERGROUND,
	SURFACE,
	LEFT_SLOPE,
	RIGHT_SLOPE
}

const FILLED_TILE_ID = [TileID.UNDERGROUND, TileID.SURFACE]
const PARTIAL_TILE_ID = [TileID.LEFT_SLOPE, TileID.RIGHT_SLOPE]

var bounds := Rect2(0, 0, 0, 0)


func is_empty(x: int, y: int) -> bool:
	return get_cell(x, y) == -1


func is_partial(x: int, y: int) -> bool:
	return PARTIAL_TILE_ID.has(get_cell(x, y))


func is_filled(x: int, y: int) -> bool:
	return FILLED_TILE_ID.has(get_cell(x, y))


func fill(x: int) -> void:
	var surface = find_surface(x)
	var new_surface = surface - 1
	set_cell(x, surface, TileID.UNDERGROUND)
	set_cell(x, new_surface, TileID.SURFACE)
	if is_empty(x-1, new_surface) and is_filled(x-1, surface):
		set_cell(x-1, new_surface, TileID.LEFT_SLOPE)
		set_cell(x-1, surface, TileID.UNDERGROUND)
	elif is_partial(x-1, new_surface):
		set_cell(x-1, new_surface, TileID.SURFACE)
		set_cell(x-1, surface, TileID.UNDERGROUND)
	if is_empty(x+1, new_surface) and is_filled(x+1, surface):
		set_cell(x+1, new_surface, TileID.RIGHT_SLOPE)
		set_cell(x+1, surface, TileID.UNDERGROUND)
	elif is_partial(x+1, new_surface):
		set_cell(x+1, new_surface, TileID.SURFACE)
		set_cell(x+1, surface, TileID.UNDERGROUND)


func find_surface(x: int) -> int:
	for y in range(-bounds.end.y, -bounds.position.y):
		if is_filled(x, y):
			return y
	return -int(bounds.position.y) # There's a gaping hole in the map?

func get_full_tile_id() -> int:
	return TileID.UNDERGROUND

func get_surface_tile_id() -> int:
	return TileID.SURFACE
