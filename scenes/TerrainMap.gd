extends TileMap


const SURFACE_TILE_ID = 1
const UNDERGROUND_TILE_ID = 0
const PARTIAL_TILE_ID = [2, 3]


func is_empty(x: int, y: int) -> bool:
	return get_cell(x, y) == -1


func is_partial(x: int, y: int) -> bool:
	return PARTIAL_TILE_ID.has(get_cell(x, y))


func fill(x: int, y: int) -> void:
	var id := SURFACE_TILE_ID
	if get_cell(x, y-1) != -1:
		id = UNDERGROUND_TILE_ID # Figure out correct id
	set_cell(x, y, id)
	if id == SURFACE_TILE_ID: # Make sure ground
		set_cell(x, y+1, UNDERGROUND_TILE_ID)


func get_full_tile_id() -> int:
	return UNDERGROUND_TILE_ID

func get_surface_tile_id() -> int:
	return SURFACE_TILE_ID
