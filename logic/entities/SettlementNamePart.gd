extends Node2D


var settlement_name := "FOOBAR" setget set_settlement_name


func set_settlement_name(n: String) -> void:
	settlement_name = n
	$Background/Label.text = n


func _process(_delta: float) -> void:
	var entity = get_parent()
	var box: Rect2 = entity.calc_bounding_box()
	position = box.position + box.size / 2.0
