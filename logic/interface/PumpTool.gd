extends "BuildToolNode.gd"

const MoneyCost = 1000
const ManpowerCost = 25

func can_build() -> bool:
	return Root.resources.money >= MoneyCost and \
	Root.construction_manager.can_construct_pump(cell_under_mouse)


func build() -> void:
	Root.construction_manager.queue_construction(
		cell_under_mouse, "construct_pump", "can_progress_pump",
		MoneyCost, ManpowerCost
	)

