extends Node2D

func _ready() -> void:
	get_parent().connect("mouse_entered", self, "_on_mouse_entered")
	get_parent().connect("mouse_exited", self, "_on_mouse_exited")
	visible = false


func _on_mouse_entered() -> void:
	visible = true


func _on_mouse_exited() -> void:
	visible = false

