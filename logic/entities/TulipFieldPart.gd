extends "EntityPart.gd"

func is_top() -> bool:
	return not get_parent().has_part_at(cell_x, cell_y-1)

func destroy() -> void:
	if not is_top():
		get_parent().get_part_at(cell_x, cell_y-1).destroy()
	.destroy()

func get_rect() -> Rect2:
	var rect = $Sprite.get_rect()
	rect.position += position
	return rect
