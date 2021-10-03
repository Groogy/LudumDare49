extends "BuildToolNode.gd"


func can_build() -> bool:
	return Root.construction_manager.can_destroy_entity_part_at(cell_under_mouse)


func build() -> void:
	Root.construction_manager.destroy_entity_part_at(cell_under_mouse)

