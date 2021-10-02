tool
extends Node2D

export var generation_seed: int = 0
export var target_area := Rect2(0, 0, 100, -100)

func _ready() -> void:
	_generate_terrain()


func _enter_tree() -> void:
	request_ready()


func _draw() -> void:
	if Engine.editor_hint:
		var map: TileMap = get_parent()
		var start = map.map_to_world(target_area.position)
		var end = map.map_to_world(target_area.end)
		draw_rect(Rect2(start, end), Color.blueviolet, false, 2.0, false)


func _generate_terrain() -> void:
	var map: TileMap = get_parent()
	map.clear()
	for x in range(target_area.position.x, target_area.end.x):
		map.fill(x, -1) #Set a level playing field
