extends "BuildToolNode.gd"


func can_build() -> bool:
	return .can_build() and \
	Root.construction_manager.can_construct_pipe(cell_under_mouse)


func build() -> void:
	# Pipes are special
	Root.construction_manager.construct_pipe(cell_under_mouse, get_money_cost(), get_workers_cost())
	

func get_money_cost() -> float:
	return 50.0


func get_workers_cost() -> int:
	return 5

func generate_tooltip() -> String:
	var tooltip = .generate_tooltip()
	if not tooltip.empty(): return tooltip
	if not Root.construction_manager.can_construct_pipe(cell_under_mouse):
		return "Can't build Pipe here"
	return ""
