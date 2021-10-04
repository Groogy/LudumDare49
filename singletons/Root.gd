extends Node

onready var map_manager = null
onready var construction_manager = null
onready var tool_manager = null
onready var resources = null
onready var workers_dispatch = null

func setup() -> void:
	map_manager = $"/root/Game/MapManager"
	construction_manager = $"/root/Game/ConstructionManager"
	tool_manager = $"/root/Game/ToolManager"
	resources = $"/root/Game/Resources"
	workers_dispatch = $"/root/Game/WorkersDispatch"
