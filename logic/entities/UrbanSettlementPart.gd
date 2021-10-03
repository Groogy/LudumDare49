extends "EntityPart.gd"


func _ready() -> void:
	randomize_settlement_sprite()


func randomize_settlement_sprite() -> void:
	var random = randi() % $Sprite.hframes
	$Sprite.frame = random


func get_rect() -> Rect2:
	var rect = $Sprite.get_rect()
	rect.position += position
	return rect
