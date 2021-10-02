extends "EntityPart.gd"

var orientation: int = Const.PipeOrientations.HORIZONTAL setget set_orientation


func set_orientation(val: int) -> void:
	assert(Const.PipeOrientations.values().has(val))
	orientation = val
	$Sprite.frame = val
