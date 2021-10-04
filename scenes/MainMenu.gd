extends Node2D



func _on_StartGame_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")
	


func _on_QuitGame_pressed():
	get_tree().quit()


func _on_Help_pressed():
	pass # Replace with function body.
