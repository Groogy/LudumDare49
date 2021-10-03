extends "BuildToolNode.gd"

const MoneyCost = 100
const ManpowerCost = 10

func can_build() -> bool:
	return Root.resources.money >= MoneyCost and \
	Root.construction_manager.can_construct_pipe(cell_under_mouse)


func build() -> void:
	Root.construction_manager.queue_construction(
		cell_under_mouse, "construct_pipe", "can_construct_pipe",
		MoneyCost, ManpowerCost
	)

