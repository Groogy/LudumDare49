extends "BuildToolNode.gd"


func can_build() -> bool:
	return .can_build() and \
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


func generate_tooltip() -> String:
	var tooltip = .generate_tooltip()
	if not tooltip.empty(): return tooltip
	if not Root.construction_manager.can_raise_land(cell_under_mouse):
		return "Can't raise land here"
	return ""
