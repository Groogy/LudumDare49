tool
extends Node2D

export(NodePath) var _terrain_map
export(NodePath) var _water_map
export(NodePath) var _entities


export var generation_seed: int = 0 setget set_generation_seed
export var target_area := Rect2(0, 0, 100, 100)
export var start_y := 8
export var start_settlement_area := Rect2(0, 0, 100, 100)
export var start_settlement_max_size := 3


func get_terrain_map() -> TileMap:
	if _terrain_map.is_empty(): return null
	return get_node(_terrain_map) as TileMap
	
func get_water_map() -> TileMap:
	if _water_map.is_empty(): return null
	return get_node(_water_map) as TileMap

func get_entities() -> Node2D:
	if _entities.is_empty(): return null
	return get_node(_entities) as Node2D


func _ready() -> void:
	_generate_world()


func set_generation_seed(val: int) -> void:
	generation_seed = val
	if Engine.editor_hint:
		request_ready()

func _generate_world() -> void:
	if not get_terrain_map(): return
	if generation_seed == 0:
		randomize()
	else:
		seed(generation_seed)
	
	get_terrain_map().clear()
	if not Engine.editor_hint:
		get_water_map().clear()
		get_entities().clear()
	for child in get_children():
		child.generate()
		child.update()
