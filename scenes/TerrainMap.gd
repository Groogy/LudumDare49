extends TileMap


const FULL_TILE_ID = 0
const PARTIAL_TILE_ID = 1


func is_empty(x: int, y: int) -> bool:
	return get_cell(x, y) == -1


func is_partial(x: int, y: int) -> bool:
	return get_cell(x, y) == PARTIAL_TILE_ID
