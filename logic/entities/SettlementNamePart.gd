extends Node2D

func _process(_delta: float) -> void:
	var entity = get_parent()
	var box: Rect2 = entity.calc_bounding_box()
	position = box.position + box.size / 2.0
