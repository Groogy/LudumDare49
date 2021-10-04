extends "BuildToolNode.gd"


func can_build() -> bool:
	return .can_build() and \
	Root.construction_manager.can_construct_tulips(cell_under_mouse)


func build() -> void:
	Root.construction_manager.queue_construction(
		cell_under_mouse, null, [],
		 "construct_tulips", "can_progress_tulips",
		get_money_cost(), get_workers_cost()
	)

func get_money_cost() -> float:
	return 200.0


func get_workers_cost() -> int:
	return 5

func generate_tooltip() -> String:
	var tooltip = .generate_tooltip()
	if not tooltip.empty(): return tooltip
	if not Root.construction_manager.can_construct_tulips(cell_under_mouse):
		return "Can't build Tulip Field here"
	return ""
