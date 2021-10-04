extends "BuildToolNode.gd"


func can_build() -> bool:
	return .can_build() and \
	Root.construction_manager.can_construct_pump(cell_under_mouse)


func build() -> void:
	Root.construction_manager.queue_construction(
		cell_under_mouse, null, [],
		 "construct_pump", "can_progress_pump",
		get_money_cost(), get_workers_cost()
	)

func get_money_cost() -> float:
	return 500.0


func get_workers_cost() -> int:
	return 25
