extends "BuildToolNode.gd"


func can_build() -> bool:
	return .can_build() and \
	Root.construction_manager.can_lower_land(cell_under_mouse)


func build() -> void:
	Root.construction_manager.queue_construction(
		cell_under_mouse, null, ["lowered_land_construction"],
		 "lower_land", "can_progress_lower_land",
		get_money_cost(), get_workers_cost()
	)

func get_money_cost() -> float:
	return 500.0


func get_workers_cost() -> int:
	return 100

func generate_tooltip() -> String:
	var tooltip = .generate_tooltip()
	if not tooltip.empty(): return tooltip
	if not Root.construction_manager.can_lower_land(cell_under_mouse):
		if Root.map_manager.water.has_water(cell_under_mouse.x, cell_under_mouse.y):
			return "Can't lower land in water"
		else:
			return "Can't lower land here"
	return ""
