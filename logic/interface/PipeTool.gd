extends "BuildToolNode.gd"


func can_build() -> bool:
	return Root.resources.money >= get_money_cost() and \
	Root.construction_manager.can_construct_pipe(cell_under_mouse)


func build() -> void:
	Root.construction_manager.queue_construction(
		cell_under_mouse, null, [],
		"construct_pipe", "can_progress_pipe",
		get_money_cost(), get_workers_cost()
	)

func get_money_cost() -> float:
	return 50.0


func get_workers_cost() -> int:
	return 5
