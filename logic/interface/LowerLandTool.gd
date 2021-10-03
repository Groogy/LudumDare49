extends "BuildToolNode.gd"

const MoneyCost = 500
const ManpowerCost = 250

func can_build() -> bool:
	return Root.resources.money >= MoneyCost and \
	Root.construction_manager.can_lower_land(cell_under_mouse)


func build() -> void:
	Root.construction_manager.queue_construction(
		cell_under_mouse, "lower_land", "can_lower_land",
		MoneyCost, ManpowerCost
	)

