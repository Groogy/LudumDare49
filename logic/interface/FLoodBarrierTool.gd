extends "BuildToolNode.gd"


func can_build() -> bool:
	return Root.construction_manager.can_construct_flood_barrier(cell_under_mouse)


func build() -> void:
	Root.construction_manager.construct_flood_barrier(cell_under_mouse)

