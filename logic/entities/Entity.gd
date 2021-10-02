class_name Entity
extends Node2D

func is_on(x: int, y: int) -> bool:
	for child in get_children():
		if child.is_on(x, y):
			return true
	return false
