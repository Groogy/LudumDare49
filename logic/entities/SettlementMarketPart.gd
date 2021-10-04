extends "EntityPart.gd"


var multiplier := 1.0 setget set_multiplier


func _ready() -> void:
	$Info.visible = false
	

func _process(_delta: float) -> void:
	if $Info.visible:
		_update_info()


func set_multiplier(val: float) -> void:
	multiplier = val


func get_rect() -> Rect2:
	var rect = $Sprite.get_rect()
	rect.position += position
	return rect


func generated_income() -> float:
	return 40.0 * multiplier


func generated_workers() -> int:
	return $WorkersManager.generated_workers()


func free_workers() -> int:
	return $WorkersManager.free_workers


func request_workers(var target: EntityPart, var cap: int) -> int:
	var amount: int = min(cap, $WorkersManager.free_workers)
	$WorkersManager.free_workers -= amount
	if amount > 0:
		var growth = get_parent().get_all_parts_in("settlement_growth")
		growth.front().lose_growth(amount)
		Root.workers_dispatch.request_workers(self, target, amount)
	return amount


func _update_info() -> void:
	$Info/Container/VBox/Grid/MoneyValue.text = "+%.1f" % generated_income()
	$Info/Container/VBox/Grid/WorkersValue.text = "+%d" % generated_workers()

func _on_mouse_entered():
	$Info.visible = true


func _on_mouse_exited():
	$Info.visible = false
