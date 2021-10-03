extends Node2D


var settlement_name := "FOOBAR" setget set_settlement_name


onready var _background_pos_cache: PoolVector2Array = $Background.polygon
var _dirty_background = false


func set_settlement_name(n: String) -> void:
	settlement_name = n
	$Background/Label.text = n
	_dirty_background = true


func _process(_delta: float) -> void:
	var entity = get_parent()
	var box: Rect2 = entity.calc_bounding_box()
	position = box.position + box.size / 2.0
	position.y += 20
	if _dirty_background:
		_update_background()


func _update_background() -> void:
	_dirty_background = true
	var size = $Background/Label.rect_size / 2
	for i in $Background.polygon.size():
		var pos = _background_pos_cache[i]
		pos.x += size.x * sign(pos.x)
		$Background.polygon[i] = pos
