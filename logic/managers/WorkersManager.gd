extends Node

onready var free_workers: int = get_parent().generated_workers() * 10

func on_growth() -> void:
	free_workers += get_parent().generated_workers()
