extends Node2D



func _on_Continue_pressed():
	visible = false
	pass # Replace with function body.


func _on_Restart_Game_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")


func _on_Help_pressed():
	$HelpInfo.visible = true


func _on_MasterAudio_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))


func _on_SfxAudio_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), linear2db(value))


func _on_Quit_pressed():
	get_tree().quit()
