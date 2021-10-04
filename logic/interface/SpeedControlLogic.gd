extends Node






func _on_Speed1_pressed():
	Engine.time_scale = 1.0
	$"../Label".text = "Speed x1"


func _on_Speed2_pressed():
	Engine.time_scale = 2.0
	$"../Label".text = "Speed x2"


func _on_Speed3_pressed():
	Engine.time_scale = 4.0
	$"../Label".text = "Speed x4"
