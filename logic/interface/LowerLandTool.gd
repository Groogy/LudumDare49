extends "BuildToolNode.gd"


func can_build() -> bool:
	return Root.construction_manager.can_lower_land(cell_under_mouse)


func build() -> void:
	Root.construction_manager.lower_land(cell_under_mouse)

