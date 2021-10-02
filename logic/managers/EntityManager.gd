extends Node2D


const FloodBarrierScene = preload("res://scenes/FloodBarrier.tscn")


func is_empty(x: int, y: int) -> bool:
	for child in get_children():
		if child.is_on(x, y):
			return false
	return true


func is_water_blocked(x: int, y: int) -> bool:
	return not is_empty(x, y)


func has_flood_barrier_at(x, y) -> bool:
	return not is_empty(x, y)


func create_flood_barrier(cell: Vector2) -> void:
	var barrier := FloodBarrierScene.instance()
	barrier.set_cell(cell)
	add_child(barrier)
