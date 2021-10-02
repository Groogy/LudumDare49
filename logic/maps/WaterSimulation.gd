extends Node


const MAX_SIMULATION_DEPTH = 64
const MAX_FLOW_DEPTH = 1


func _on_simulation() -> void:
	var map := get_parent()
	for cell in map.get_used_cells():
		_simulate_cell(cell)


func _simulate_cell(cell: Vector2, depth := 0, flow_dir := 0) -> void:
	if depth >= MAX_SIMULATION_DEPTH: return
	var manager = Root.map_manager
	if manager.can_have_more_water(cell.x, cell.y+1):
		_simulate_gravity(cell, depth)
	if flow_dir >= 0 and manager.can_have_more_water(cell.x + 1, cell.y):
		_simulate_flow(cell, 1, depth)
	if flow_dir <= 0 and manager.can_have_more_water(cell.x - 1, cell.y):
		_simulate_flow(cell, -1, depth)


func _simulate_gravity(cell: Vector2, depth := 0) -> void:
	var map := get_parent()
	var value = map.get_water_level_at(cell.x, cell.y)
	if value <= 0: return
	map.set_water_level_at(cell.x, cell.y, 0)
	map.add_water_level_at(cell.x, cell.y+1, value)
	if Root.map_manager.can_have_more_water(cell.x, cell.y+1):
		_simulate_cell(cell + Vector2(0, 1), depth+1)


func _simulate_flow(cell: Vector2, dir: int, depth := 0) -> void:
	if depth >= MAX_FLOW_DEPTH: return
	var map = get_parent()
	var target = cell + Vector2(dir, 0)
	var my_level = map.get_water_level_at(cell.x, cell.y)
	var target_level = map.get_water_level_at(target.x, target.y)
	if my_level > 1 and my_level > target_level:
		map.add_water_level_at(cell.x, cell.y, -1)
		map.add_water_level_at(target.x, target.y, 1)
		_simulate_cell(target, depth+1, dir)
