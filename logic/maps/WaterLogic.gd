extends Node


func _on_inject_water():
	var map := get_parent()
	var injection: Vector2 = map.inject_water_pos
	map.add_water_level_at(injection.x, injection.y, 1)
