extends Node2D


const SettlementUrbanPart = preload("res://scenes/entities/SettlementUrbanPart.tscn")


onready var _valuebar_pos_cache: PoolVector2Array = $ValueBar.polygon

var _current_growth_value := 0.0


func _process(_delta: float) -> void:
	_update_position()
	_update_value_bar()
	if _current_growth_value >= 1.0:
		perform_growth_spurt()


func perform_growth_spurt() -> void:
	_current_growth_value = 0.0
	if randi() % 10 == 0:
		settle_new_settlement()
		# Found a new city
		pass
	elif randi() % 5 == 0:
		expand_settlement()
		pass
	else:
		increase_multiplier()


func settle_new_settlement() -> void:
	# TODO
	expand_settlement()


func expand_settlement() -> void:
	var entity: Entity = get_parent()
	var parts := entity.get_all_parts_in("settlement_part")
	var surface = parts.front().cell_y
	var left: int = parts.front().cell_x
	var right: int = parts.back().cell_x
	for part in parts:
		if part.cell_x <= left: left = part.cell_x-1
		if part.cell_x >= right: right = part.cell_x+1
	var valid = []
	if Root.map_manager.can_place_settlement_part_on(left, surface):
		valid.push_back(Vector2(left, surface))
	if Root.map_manager.can_place_settlement_part_on(right, surface):
		valid.push_back(Vector2(right, surface))
	if valid.empty():
		increase_multiplier()
	else:
		var part := SettlementUrbanPart.instance()
		part.set_cell(valid[randi()%valid.size()])
		entity.add_child(part)


func increase_multiplier() -> void:
	var parts = get_parent().get_all_parts_in("settlement_part")
	parts[randi()%parts.size()].multiplier += 0.1


func _update_position() -> void:
	var entity = get_parent()
	var box: Rect2 = entity.calc_bounding_box()
	position = box.position + box.size / 2.0
	position.y += 36
	

func _update_value_bar() -> void:
	for i in $ValueBar.polygon.size():
		var pos = _valuebar_pos_cache[i]
		pos.x *= _current_growth_value
		$ValueBar.polygon[i] = pos


func _on_growth():
	_current_growth_value += 0.01

