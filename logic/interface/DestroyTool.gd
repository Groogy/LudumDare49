extends "BuildToolNode.gd"


func can_build() -> bool:
	return Root.construction_manager.can_destroy_entity_part_at(cell_under_mouse)


func build() -> void:
	Root.construction_manager.destroy_entity_part_at(cell_under_mouse)


func generate_tooltip() -> String:
	var part = Root.map_manager.entities.fetch_part_at(cell_under_mouse.x, cell_under_mouse.y)
	if not part: return ""
	if part.is_in_group("player_constructed"): return ""
	return "Can't destroy this" 


func get_money_cost() -> float:
	return 0.0


func get_workers_cost() -> int:
	return 0
