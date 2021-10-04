extends Node2D


var health := 1.0
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


func _physics_process(delta) -> void:
	var parent = get_parent()
	var water = Root.map_manager.water
	var level = water.get_water_level_at(parent.cell_x-1, parent.cell_y)
	level += water.get_water_level_at(parent.cell_x, parent.cell_y)
	level += water.get_water_level_at(parent.cell_x+1, parent.cell_y)
	if level > 0:
		_update_damage(level)
	
	
func _update_damage(water) -> void:
	if water > 32 + durability or randi() % (33 + durability - water) == 0:
		health -= 0.1
	if health <= 0.0:
		get_parent().destroy()
