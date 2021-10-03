extends "EntityPart.gd"

var orientation: int = Const.PipeOrientations.HORIZONTAL setget set_orientation
var connections := []


func suck(strength: int):
	var to_check = [
		Vector2(0, -1), Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0),
		Vector2(0, 1)
	]
	var water = Root.map_manager.water
	var entities = Root.map_manager.entities
	var valid := []
	for check in to_check:
		var coord = get_cell() + check
		if water.get_water_level_at(coord.x, coord.y) <= 0:
			continue
		if entities.has_pipe_at(coord.x, coord.y):
			continue
		valid.append(coord)
	if valid.empty(): return
	var random = valid[randi() % valid.size()]
	strength = clamp(strength, 0, water.get_water_level_at(random.x, random.y))
	water.add_water_level_at(random.x, random.y, -strength)


func set_orientation(val: int) -> void:
	assert(Const.PipeOrientations.values().has(val))
	orientation = val
	$Sprite.frame = val
	

func is_free() -> bool:
	return connections.size() < 2


func get_other_connection(a: EntityPart) -> EntityPart:
	assert(connections.has(a))
	assert(connections.size() == 2)
	if connections.front() == a: return connections.back()
	else: return connections.front()


func connect_pipe(part: EntityPart) -> void:
	assert(connections.size() < 2)
	connections.push_back(part)
	var is_pipe := part.is_in_group("pipe")
	if is_pipe:
		assert(part.connections.size() < 2)
		part.connections.push_back(self)
	if cell_x == part.cell_x:
		set_orientation(Const.PipeOrientations.VERTICAL)
	if cell_y == part.cell_y:
		set_orientation(Const.PipeOrientations.HORIZONTAL)
	if is_pipe:
		var other: EntityPart = part.get_other_connection(self)
		if other.cell_y != cell_y and other.cell_x != cell_x:
			var orientatio: int = Const.PipeOrientations.VERTICAL
			var is_reverse := other.cell_x < cell_x
			if other.cell_y < cell_y and part.cell_y == cell_y:
				if is_reverse: orientation = Const.PipeOrientations.RIGHT_UP
				else: orientation = Const.PipeOrientations.LEFT_UP
			elif other.cell_y < cell_y and part.cell_x == cell_x:
				if is_reverse: orientation = Const.PipeOrientations.LEFT_DOWN
				else: orientation = Const.PipeOrientations.RIGHT_DOWN
			elif other.cell_y > cell_y and part.cell_x == cell_x:
				if is_reverse: orientation = Const.PipeOrientations.LEFT_UP
				else: orientation = Const.PipeOrientations.RIGHT_UP
			elif other.cell_y > cell_y and part.cell_y == cell_y:
				if is_reverse: orientation = Const.PipeOrientations.RIGHT_DOWN
				else: orientation = Const.PipeOrientations.LEFT_DOWN
			part.orientation = orientation
