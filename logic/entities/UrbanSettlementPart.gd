extends "EntityPart.gd"


var multiplier := 1.0


func _ready() -> void:
	randomize_settlement_sprite()


func randomize_settlement_sprite() -> void:
	var random = randi() % $Sprite.hframes
	$Sprite.frame = random


func get_rect() -> Rect2:
	var rect = $Sprite.get_rect()
	rect.position += position
	return rect


func generated_income() -> float:
	return 0.1 * multiplier


func generated_workers() -> int:
	return int(1 * multiplier)


func free_workers() -> int:
	return $WorkersManager.free_workers
	
