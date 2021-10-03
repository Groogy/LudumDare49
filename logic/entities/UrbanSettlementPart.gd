extends "EntityPart.gd"


func _ready() -> void:
	randomize_settlement_sprite()


func randomize_settlement_sprite() -> void:
	var random = randi() % $Sprite.hframes
	$Sprite.frame = random
