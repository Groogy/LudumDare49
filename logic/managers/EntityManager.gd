extends Node2D


func clear() -> void:
	var children := get_children()
	for child in children:
		child.queue_free()


func is_empty(x: int, y: int) -> bool:
	for child in get_children():
		if child.is_on(x, y):
			return false
	return true


func is_water_blocked(x: int, y: int) -> bool:
	return has_entity_part_at(x, y, "blocks_water")


func has_entity_part_at(x: int, y: int, group: String) -> bool:
	for child in get_children():
		if child.has_part_at(x, y, group):
			return true
	return false


func has_flood_barrier_at(x: int, y: int) -> bool:
	return has_entity_part_at(x, y, "flood_barrier")


func has_pump_at(x: int, y: int) -> bool:
	return has_entity_part_at(x, y, "pump")


func has_pipe_at(x: int, y: int) -> bool:
	return has_entity_part_at(x, y, "pipe")


func has_free_pipe_at(x: int, y: int) -> bool:
	var pipe =  fetch_part_at(x, y)
	if not pipe or not pipe.is_in_group("pipe"):
		return false
	return pipe.is_free()


func can_connect_pipe(x: int, y: int) -> bool:
	var connection := find_pipe_connection(x, y)
	if not connection:
		return false
	if connection.get_parent().get_child_count() > 16:
		return false
	return true


func find_pipe_connection(x: int, y: int) -> EntityPart:
	if has_pump_at(x, y-1) or has_free_pipe_at(x, y-1): 
		return fetch_part_at(x, y-1)
	elif has_free_pipe_at(x, y+1):
		return fetch_part_at(x, y+1)
	elif has_free_pipe_at(x-1, y):
		return fetch_part_at(x-1, y)
	elif has_free_pipe_at(x+1, y):
		return fetch_part_at(x+1, y)
	return null


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


func fetch_part_at(x: int, y: int) -> EntityPart:
	for child in get_children():
		if child.is_on(x, y):
			return child.get_part_at(x, y)
	return null


func fetch_all_parts_of(group: String) -> Array:
	var parts := []
	for child in get_children():
		for part in child.get_children():
			if part.is_in_group(group):
				parts.push_back(part)
	return parts
