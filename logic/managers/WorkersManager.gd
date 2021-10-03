extends Node

var free_workers := 0

func on_growth() -> void:
	free_workers += get_parent().generated_workers()
