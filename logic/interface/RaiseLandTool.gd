extends "BuildToolNode.gd"


func can_build() -> bool:
	return  Root.construction_manager.can_raise_land(cell_under_mouse)


func build() -> void:
	Root.construction_manager.raise_land(cell_under_mouse)

