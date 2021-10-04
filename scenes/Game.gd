extends Node2D

func _enter_tree() -> void:
	Root.setup()
	$Interface/IngameMenu.visible = false


func _unhandled_input(event):
	if event.is_action_pressed("ingame_menu"):
		$Interface/IngameMenu.visible = !$Interface/IngameMenu.visible
		get_tree().set_input_as_handled()
