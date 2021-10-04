extends "BuildToolNode.gd"

func can_build() -> bool:
	return Root.resources.money >= get_money_cost() and \
	Root.construction_manager.can_raise_land(cell_under_mouse)


func build() -> void:
	Root.construction_manager.queue_construction(
		cell_under_mouse, null, [],
		 "raise_land", "can_progress_raise_land",
		get_money_cost(), get_workers_cost()
	)

func get_money_cost() -> float:
	return 500.0


func get_workers_cost() -> int:
	return 250
