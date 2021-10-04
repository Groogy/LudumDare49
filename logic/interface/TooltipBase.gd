extends Node2D


export var connect_to_parent := true


func _ready() -> void:
	if connect_to_parent:
		get_parent().connect("mouse_entered", self, "_on_mouse_entered")
		get_parent().connect("mouse_exited", self, "_on_mouse_exited")
	visible = false


func _on_mouse_entered() -> void:
	visible = true


func _on_mouse_exited() -> void:
	visible = false

