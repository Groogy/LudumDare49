extends Node

onready var free_workers: int = generated_workers() * 10

var multiplier := 1.0
export var _generated_workers := 1.0

func generated_workers() -> int:
	return int(_generated_workers * multiplier * Root.workers_dispatch.multiplier)
	

func on_growth() -> void:
	free_workers += generated_workers()
