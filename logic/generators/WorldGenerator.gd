tool
extends Node2D

export(NodePath) var _terrain_map
export(NodePath) var _water_map
export(NodePath) var _entities


export var generation_seed: int = 0 setget set_generation_seed
export var target_area := Rect2(0, 0, 100, 100)
export var start_settlement_area := Rect2(0, 0, 100, 100)


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
	$TerrainGenerator.generate_terrain()


func set_generation_seed(val: int) -> void:
	generation_seed = val
	if Engine.editor_hint:
		request_ready()
