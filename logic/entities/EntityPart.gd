class_name EntityPart
extends Node2D


var cell_x := 0 setget set_cell_x
var cell_y := 0 setget set_cell_y


func is_on(x: int, y: int) -> bool:
	return cell_x == x and cell_y == y


func get_cell() -> Vector2:
	return Vector2(cell_x, cell_y)


func set_cell(v: Vector2) -> void:
	cell_x = int(v.x)
	cell_y = int(v.y)
	position = Root.map_manager.map_to_world(v)


func set_cell_x(x: int) -> void:
	cell_x = x
	position = Root.map_manager.map_to_world(Vector2(cell_x, cell_y))


func set_cell_y(y: int) -> void:
	cell_y = y
	position = Root.map_manager.map_to_world(Vector2(cell_x, cell_y))


func get_rect() -> Rect2:
	return Rect2(global_position, Vector2(16, 16))


func worker_arrived() -> void:
	for child in get_children():
		if child.has_method("worker_arrived"):
			child.worker_arrived()


func destroy() -> void:
	var parent = get_parent()
	parent.remove_child(self)
	parent.check_destroyed()
	queue_free()
