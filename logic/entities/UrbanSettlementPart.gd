extends "EntityPart.gd"


var multiplier := 1.0 setget set_multiplier


func _ready() -> void:
	randomize_settlement_sprite()
	$Info.visible = false
	

func _process(_delta: float) -> void:
	if $Info.visible:
		_update_info()


func set_multiplier(val: float) -> void:
	multiplier = val


func randomize_settlement_sprite() -> void:
	var random = randi() % $Sprite.hframes
	$Sprite.frame = random


func get_rect() -> Rect2:
	var rect = $Sprite.get_rect()
	rect.position += position
	return rect


func generated_income() -> float:
	return 0.5 * multiplier


func generated_workers() -> int:
	return int(1 * multiplier)


func free_workers() -> int:
	return $WorkersManager.free_workers


func _update_info() -> void:
	$Info/Container/VBox/Grid/MoneyValue.text = "+%.1f" % generated_income()
	$Info/Container/VBox/Grid/WorkersValue.text = "+%d" % generated_workers()

func _on_mouse_entered():
	$Info.visible = true


func _on_mouse_exited():
	$Info.visible = false
