extends "EntityPart.gd"


var build_callback := ""
var can_build_callback := ""
var needed_workers := 0
var provided_workers := 0

onready var _valuebar_pos_cache: PoolVector2Array = $ValueBar.polygon


func _process(_delta: float) -> void:
	for i in $ValueBar.polygon.size():
		var pos = _valuebar_pos_cache[i]
		pos.x *= get_progress()
		$ValueBar.polygon[i] = pos


func _physics_process(_delta: float) -> void:
	if can_progress() and is_finished():
		finish()


func get_rect() -> Rect2:
	var rect = $Sprite.get_rect()
	rect.position += position
	return rect
	
func get_progress() -> float:
	return float(provided_workers) / float(needed_workers)


func is_finished() -> bool:
	return provided_workers >= needed_workers


func can_progress() -> bool:
	return Root.construction_manager.call(can_build_callback, get_cell())


func finish() -> void:
	Root.construction_manager.call(build_callback, get_cell())
