class_name Entity
extends Node2D

func is_on(x: int, y: int) -> bool:
	for child in get_children():
		if child.is_on(x, y):
			return true
	return false


func has_part_at(x: int, y: int, group: String = "") -> bool:
	for child in get_children():
		if child.is_on(x, y) and (group.empty() or child.is_in_group(group)):
			return true
	return false


func get_part_at(x: int, y: int) -> EntityPart:
	for child in get_children():
		if child.is_on(x, y):
			return child
	return null

func check_destroyed() -> void:
	if get_child_count() <= 0:
		queue_free()
