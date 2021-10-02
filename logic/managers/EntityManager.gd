extends Node2D


func is_empty(x: int, y: int) -> bool:
	for child in get_children():
		if child.is_on(x, y):
			return false
	return true


func is_water_blocked(x: int, y: int) -> bool:
	return not is_empty(x, y)


func has_flood_barrier_at(x: int, y: int) -> bool:
	return not is_empty(x, y)


func create_entity(parts: Array = []) -> Entity:
	var entity := Entity.new()
	for part in parts:
		entity.add_child(part)
	add_child(entity)
	return entity

func fetch_entity_at(x: int, y: int) -> Entity:
	for child in get_children():
		if child.is_on(x, y):
			return child
	return null
