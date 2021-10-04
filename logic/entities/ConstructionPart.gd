extends "EntityPart.gd"


var build_callback := ""
var can_build_callback := ""
var needed_workers := 0
var workers_on_the_way := 0
var provided_workers := 0

onready var _valuebar_pos_cache: PoolVector2Array = $ValueBar.polygon


func _process(_delta: float) -> void:
	for i in $ValueBar.polygon.size():
		var pos = _valuebar_pos_cache[i]
		pos.x *= get_progress()
		$ValueBar.polygon[i] = pos


func _physics_process(_delta: float) -> void:
	if can_progress():
		if need_more_workers():
			pull_more_workers()
		if is_finished():
			finish()


func need_more_workers() -> bool:
	return provided_workers + workers_on_the_way < needed_workers

func pull_more_workers() -> void:
	var providers = Root.map_manager.entities.fetch_all_parts_of("workers_provider")
	providers.sort_custom(self, "provider_sort")
	for provider in providers:
		var given: int = provider.request_workers(self, needed_workers - provided_workers - workers_on_the_way)
		workers_on_the_way += given
		if not need_more_workers():
			break

func provider_sort(a, b) -> bool:
	return abs(a.cell_x - cell_x) < abs(b.cell_x - cell_x)


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
