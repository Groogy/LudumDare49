extends Node2D


var health := 1.0
var waiting_for_worker := false

export var durability := 1


onready var _green_pos_cache: PoolVector2Array = $Background/Green.polygon


func _process(_delta: float) -> void:
	if health >= 1.0:
		$Background.visible = false
	else:
		$Background.visible = true
		for i in $Background/Green.polygon.size():
			var pos = _green_pos_cache[i]
			pos.x *= min(health, 1.0)
			$Background/Green.polygon[i] = pos


func _update_damage(water) -> void:
	if water > 32 + durability or randi() % (33 + durability - water) == 0:
		health -= 0.1
		if not waiting_for_worker:
			_request_worker()
	if health <= 0.0:
		get_parent().destroy()


func _request_worker():
	waiting_for_worker = true
	var providers = Root.map_manager.entities.fetch_all_parts_of("workers_provider")
	providers.sort_custom(self, "provider_sort")
	for provider in providers:
		var provided = provider.request_workers(get_parent(), 1)
		if provided > 0:
			break


func provider_sort(a, b) -> bool:
	return abs(a.cell_x - get_parent().cell_x) < abs(b.cell_x - get_parent().cell_x)


func worker_arrived() -> void:
	health = 1.0
	waiting_for_worker = false


func _on_damage_tick():
	var parent = get_parent()
	var water = Root.map_manager.water
	var level = water.get_water_level_at(parent.cell_x-1, parent.cell_y)
	level += water.get_water_level_at(parent.cell_x, parent.cell_y)
	level += water.get_water_level_at(parent.cell_x+1, parent.cell_y)
	if level > 0:
		_update_damage(level)
