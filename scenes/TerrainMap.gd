tool
extends TileMap


enum TileID {
	EMPTY = -1
	UNDERGROUND,
	SURFACE,
	LEFT_SLOPE,
	RIGHT_SLOPE
}

const FILLED_TILE_ID = [TileID.UNDERGROUND, TileID.SURFACE]
const PARTIAL_TILE_ID = [TileID.LEFT_SLOPE, TileID.RIGHT_SLOPE]


var map_bounds := Rect2(0, 0, 0, 0)


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


func empty(x: int) -> void:
	var surface = find_surface(x, true)
	var new_surface = surface + 1
	set_cell(x, surface, TileID.EMPTY)
	set_cell(x, new_surface, TileID.SURFACE)
	if is_filled(x-1, surface):
		if is_partial(x-2, surface):
			set_cell(x-1, surface, TileID.EMPTY)
			set_cell(x-2, surface, TileID.EMPTY)
			set_cell(x-1, new_surface, TileID.SURFACE)
			set_cell(x-2, new_surface, TileID.SURFACE)
		else:
			set_cell(x-1, surface, TileID.RIGHT_SLOPE)
	elif is_partial(x-1, surface):
		set_cell(x-1, new_surface, TileID.SURFACE)
		set_cell(x-1, surface, TileID.EMPTY)
	if is_filled(x+1, surface):
		if is_partial(x+2, surface):
			set_cell(x+1, surface, TileID.EMPTY)
			set_cell(x+2, surface, TileID.EMPTY)
			set_cell(x+1, new_surface, TileID.SURFACE)
			set_cell(x+2, new_surface, TileID.SURFACE)
		else:
			set_cell(x+1, surface, TileID.LEFT_SLOPE)
	elif is_partial(x+1, surface):
		set_cell(x+1, new_surface, TileID.SURFACE)
		set_cell(x+1, surface, TileID.EMPTY)


func find_surface(x: int, include_partial: bool = false) -> int:
	for y in range(-map_bounds.end.y, -map_bounds.position.y):
		if (include_partial and not is_empty(x, y)) or is_filled(x, y):
			return y
	return -int(map_bounds.position.y) # There's a gaping hole in the map?

func get_full_tile_id() -> int:
	return TileID.UNDERGROUND

func get_surface_tile_id() -> int:
	return TileID.SURFACE
