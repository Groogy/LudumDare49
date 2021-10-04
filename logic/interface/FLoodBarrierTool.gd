extends "BuildToolNode.gd"


func can_build() -> bool:
	return .can_build() and \
	Root.construction_manager.can_construct_flood_barrier(cell_under_mouse)


func build() -> void:
	var entity: Entity = Root.map_manager.entities.fetch_entity_at(cell_under_mouse.x, cell_under_mouse.y + 1)
	Root.construction_manager.queue_construction(
		cell_under_mouse, entity, ["flood_barrier"],
		 "construct_flood_barrier", "can_progress_flood_barrier",
		get_money_cost(), get_workers_cost()
	)

func get_money_cost() -> float:
	return 100.0


func get_workers_cost() -> int:
	return 10


func generate_tooltip() -> String:
	var tooltip = .generate_tooltip()
	if not tooltip.empty(): return tooltip
	if not Root.construction_manager.can_construct_flood_barrier(cell_under_mouse):
		return "Can't place Flood Barrier here"
	return ""

