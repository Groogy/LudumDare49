class_name EntityPart
extends Node2D


var cell_x := 0 setget set_cell_x
var cell_y := 0 setget set_cell_y


func is_on(x: int, y: int) -> bool:
	return cell_x == x and cell_y == y


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

