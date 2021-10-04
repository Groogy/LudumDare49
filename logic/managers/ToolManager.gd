extends Node


var current_tool: int = Const.Tool.NONE setget set_current_tool


onready var _tools := [null, $RaiseLandTool, $LowerLandTool, $FloodBarrierTool, $PipeTool, $PumpTool, $DestroyTool]


func _ready() -> void:
	for child in get_children():
		child.visible = false


func get_tool(flag: int):
	return _tools[flag]


func set_current_tool(var flag) -> void:
	if current_tool != Const.Tool.NONE:
		_tools[current_tool].visible = false
	current_tool = flag
	if current_tool != Const.Tool.NONE:
		_tools[current_tool].visible = true
