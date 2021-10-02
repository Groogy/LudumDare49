extends Node


func _on_simulation() -> void:
	var map := get_parent()
	for cell in map.get_used_cells():
		_simulate_cell(cell)


func _simulate_cell(cell: Vector2) -> void:
	var manager = get_parent().get_parent()
	if manager.can_have_more_water(cell.x, cell.y+1):
		_simulate_gravity(cell)


func _simulate_gravity(cell: Vector2) -> void:
	var map := get_parent()
	map.add_water_level_at(cell.x, cell.y, -1)
	map.add_water_level_at(cell.x, cell.y+1, 1)
