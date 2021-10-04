extends Polygon2D


const MovementSpeed = 64 # 4 tiles a second


var target: EntityPart

func _physics_process(delta: float):
	if not is_instance_valid(target):
		queue_free()
		return
	var current_cell = Root.map_manager.world_to_map(global_position)
	if current_cell.x == target.cell_x:
		on_reached(current_cell)
	else:
		update_movement(current_cell, delta)

func on_reached(current_cell) -> void:
	var entity = target.get_parent()
	if entity:
		entity.worker_arrived()
	queue_free()


func update_movement(current_cell, delta) -> void:
	var dir = sign(target.cell_x-current_cell.x)
	var next_cell = current_cell + Vector2(dir, 0)
	next_cell.y = Root.map_manager.terrain.find_surface(next_cell.x) - 1
	if next_cell.y > current_cell.y and Root.map_manager.terrain.is_partial(next_cell.x, next_cell.y):
		next_cell.y -= 1
	var next_pos = Root.map_manager.map_to_world(next_cell)
	position.x += MovementSpeed * dir * delta
	position.y = lerp(position.y, next_pos.y, next_pos.x/position.x/16.0)
