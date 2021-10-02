extends Node

func can_raise_dyke(cell: Vector2) -> bool:
	return Root.map_manager.is_empty(cell.x, cell.y)


func raise_dyke(cell: Vector2) -> void:
	Root.map_manager.fill_terrain_cell(cell)

