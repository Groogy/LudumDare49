extends Polygon2D


const MovementSpeed = 16 # A tile a second


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
	var entity = Root.map_manager.entities.fetch_entity_at(current_cell.x, current_cell.y)
	if entity:
		entity.worker_arrived()
	queue_free()


func update_movement(current_cell, delta) -> void:
	var dir = sign(target.cell_x-current_cell.x)
	var next_cell = current_cell + Vector2(dir, 0)
	var next_pos = Root.map_manager.map_to_world(next_cell)
	var surface = Root.map_manager.terrain.find_surface(next_cell.x)
	position.x += MovementSpeed * dir * delta
	position.y = lerp(current_cell.y, next_cell.y, abs(next_pos.x-position.x)/16.0)
