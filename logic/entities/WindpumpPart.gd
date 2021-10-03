extends "EntityPart.gd"


export var sucking_power := 16


func destroy() -> void:
	get_parent().queue_free()


func find_connected_pipe() -> EntityPart:
	for child in get_parent().get_children():
		if child.is_in_group("pipe") and child.connections.has(self):
			return child
	return null # Pump has no pipes


func _on_sucking() -> void:
	var children := get_parent().get_children()
	if children.size() < 2: return
	var modified = max(sucking_power / (children.size()-1), 1)
	var random = randi() % children.size()
	if children[random] != self:
		children[random].suck(modified)


func get_rect() -> Rect2:
	var rect = $Sprite.get_rect()
	rect.position += position
	return rect
