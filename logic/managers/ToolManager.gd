extends Node


enum Tool { NONE, RAISE_DYKE, DIG_CHANNEL }


var current_tool: int = Tool.NONE setget set_current_tool


onready var _tools := [null, $RaiseDykeTool, $DigChannelTool]


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
