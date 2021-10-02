extends Node


enum Tool { NONE, RAISE_LAND, LOWER_LAND, FLOOD_BARRIER, PIPE, PUMP }


var current_tool: int = Tool.NONE setget set_current_tool


onready var _tools := [null, $RaiseLandTool, $LowerLandTool, $FloodBarrierTool, $PipeTool, $PumpTool]


func _ready() -> void:
	for child in get_children():
		child.visible = false


func set_current_tool(var flag) -> void:
	if current_tool != Tool.NONE:
		_tools[current_tool].visible = false
	current_tool = flag
	if current_tool != Tool.NONE:
		_tools[current_tool].visible = true


func get_tool_flag(name: String) -> int:
	return Tool[name]
