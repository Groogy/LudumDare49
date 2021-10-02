extends Node

func can_raise_dyke(cell: Vector2) -> bool:
	if not Root.map_manager.is_empty(cell.x, cell.y, false):
		return false
	if not will_dyke_have_support(cell):
		return false
	return true


func raise_dyke(cell: Vector2) -> void:
	Root.map_manager.fill_terrain_cell(cell)


func will_dyke_have_support(cell: Vector2) -> bool:
	var map: TileMap = Root.map_manager.terrain
	if not map.is_filled(cell.x-1, cell.y+1) or not map.is_filled(cell.x+1, cell.y+1):
		return false
		
	return true


func can_dig_channel(cell: Vector2) -> bool:
	var manager := Root.map_manager
	if manager.terrain.is_empty(cell.x, cell.y):
		return false
	if not manager.is_empty(cell.x-1, cell.y-1) \
	or not manager.is_empty(cell.x, cell.y-1) \
	or not manager.is_empty(cell.x+1, cell.y-1):
		return false
	return true


func dig_channel(cell: Vector2) -> void:
	Root.map_manager.empty_terrain_cell(cell)
