extends "EntityPart.gd"


export var sucking_power := 16


func destroy() -> void:
	get_parent().queue_free()


func _on_sucking() -> void:
	var children := get_parent().get_children()
	if children.size() < 2: return
	var modified = max(sucking_power / (children.size()-1), 1)
	var random = randi() % children.size()
	if children[random] != self:
		children[random].suck(modified)
