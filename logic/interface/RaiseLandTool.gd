extends "BuildToolNode.gd"

const MoneyCost = 500
const ManpowerCost = 250

func can_build() -> bool:
	return Root.resources.money >= MoneyCost and \
	Root.construction_manager.can_raise_land(cell_under_mouse)


func build() -> void:
	Root.construction_manager.queue_construction(
		cell_under_mouse, null, [],
		 "raise_land", "can_progress_raise_land",
		MoneyCost, ManpowerCost
	)

