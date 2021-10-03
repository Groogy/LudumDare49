tool
extends Node2D

export(NodePath) var _terrain_map
export(NodePath) var _water_map
export(NodePath) var _entities

func get_terrain_map() -> TileMap:
	return get_node(_terrain_map) as TileMap
	
func get_water_map() -> TileMap:
	return get_node(_water_map) as TileMap

func get_entities() -> Node2D:
	return get_node(_entities) as Node2D

