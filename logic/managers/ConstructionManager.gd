extends Node


const FloodBarrierScene = preload("res://scenes/FloodBarrierPart.tscn")
const WindpumpScene = preload("res://scenes/WindpumpPart.tscn")
const PipeScene = preload("res://scenes/PipePart.tscn")


func can_raise_land(cell: Vector2) -> bool:
	if not Root.map_manager.is_empty(cell.x, cell.y, false):
		return false
	if not will_land_have_support(cell):
		return false
	return true


func raise_land(cell: Vector2) -> void:
	Root.map_manager.fill_terrain_cell(cell)


func will_land_have_support(cell: Vector2) -> bool:
	var map: TileMap = Root.map_manager.terrain
	if not map.is_filled(cell.x-1, cell.y+1) or not map.is_filled(cell.x+1, cell.y+1):
		return false
		
	return true


func can_lower_land(cell: Vector2) -> bool:
	var manager := Root.map_manager
	if manager.terrain.is_empty(cell.x, cell.y):
		return false
	if not manager.is_empty(cell.x-1, cell.y-1) \
	or not manager.is_empty(cell.x, cell.y-1) \
	or not manager.is_empty(cell.x+1, cell.y-1):
		return false
	return true


func lower_land(cell: Vector2) -> void:
	Root.map_manager.empty_terrain_cell(cell)


func can_construct_flood_barrier(cell: Vector2) -> bool:
	var manager := Root.map_manager
	if not manager.terrain.is_empty(cell.x, cell.y) or not manager.entities.is_empty(cell.x, cell.y):
		return false
	if not manager.terrain.is_filled(cell.x, cell.y+1) and not manager.entities.has_flood_barrier_at(cell.x, cell.y+1):
		return false
	return true

func construct_flood_barrier(cell: Vector2) -> void:
	var barrier := FloodBarrierScene.instance()
	barrier.set_cell(cell)
	var entity: Entity = Root.map_manager.entities.fetch_entity_at(cell.x, cell.y + 1)
	if not entity:
		entity = Root.map_manager.entities.create_entity()
	entity.add_child(barrier)


func can_construct_pipe(cell: Vector2) -> bool:
	var entities = Root.map_manager.entities 
	if not entities.is_empty(cell.x, cell.y):
		return false
		
	return entities.can_connect_pipe(cell.x, cell.y)
	
	
func construct_pipe(cell: Vector2) -> void:
	var pipe := PipeScene.instance()
	pipe.set_cell(cell)
	var neighbor = Root.map_manager.entities.find_pipe_connection(cell.x, cell.y)
	neighbor.get_parent().add_child(pipe)
	pipe.connect_pipe(neighbor)


func can_construct_pump(cell: Vector2) -> bool:
	var manager := Root.map_manager
	if not manager.is_empty(cell.x, cell.y):
		return false
	if not manager.terrain.is_filled(cell.x, cell.y+1):
		return false
	return true
	
	
func construct_pump(cell: Vector2) -> void:
	var pump := WindpumpScene.instance()
	pump.set_cell(cell)
	Root.map_manager.entities.create_entity([pump])


func can_destroy_entity_part_at(cell: Vector2) -> bool:
	var entities = Root.map_manager.entities
	var part = entities.fetch_part_at(cell.x, cell.y)
	if not part:
		return false
	return true
	#
	#if part.is_in_group("flood_barrier"):
	#	return can_destroy_flood_barrier(part)
	#if part.is_in_group("pump"):
	#	return can_destroy_pump(part)
	#if part.is_in_group("pipe"):
	#	return can_destroy_pipe(part)
	#
	#return false

#func can_destroy_flood_barrier(part: EntityPart) -> bool:
#	return part.is_top()


func destroy_entity_part_at(cell: Vector2) -> void:
	var entities = Root.map_manager.entities
	var part = entities.fetch_part_at(cell.x, cell.y)
	part.destroy()
