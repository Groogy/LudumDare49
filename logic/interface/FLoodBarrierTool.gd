extends "BuildToolNode.gd"

const MoneyCost = 100
const ManpowerCost = 10


func can_build() -> bool:
	return Root.resources.money >= MoneyCost and \
	Root.construction_manager.can_construct_flood_barrier(cell_under_mouse)


func build() -> void:
	var entity: Entity = Root.map_manager.entities.fetch_entity_at(cell_under_mouse.x, cell_under_mouse.y + 1)
	Root.construction_manager.queue_construction(
		cell_under_mouse, entity, ["flood_barrier"],
		 "construct_flood_barrier", "can_progress_flood_barrier",
		MoneyCost, ManpowerCost
	)
