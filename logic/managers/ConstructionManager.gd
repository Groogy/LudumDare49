extends Node


const FloodBarrierScene = preload("res://scenes/entities/FloodBarrierPart.tscn")
const WindpumpScene = preload("res://scenes/entities/WindpumpPart.tscn")
const PipeScene = preload("res://scenes/entities/PipePart.tscn")
const ConstructionScene = preload("res://scenes/entities/ConstructionPart.tscn")

func queue_construction(cell: Vector2, build_callback: String, can_build_callback: String, money_cost: float, manpower_cost: int) -> void:
	var construction := ConstructionScene.instance()
	construction.set_cell(cell)
	construction.build_callback = build_callback
	construction.can_build_callback = can_build_callback
	construction.needed_workers = manpower_cost
	Root.resources.money -= money_cost
	Root.map_manager.entities.create_entity([construction])


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
	if not part.is_in_group("player_constructed"):
		return false
	return true


func destroy_entity_part_at(cell: Vector2) -> void:
	var entities = Root.map_manager.entities
	var part = entities.fetch_part_at(cell.x, cell.y)
	part.destroy()
