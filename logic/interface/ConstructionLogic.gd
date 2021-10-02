extends Node


func _on_raise_dyke():
	Root.tool_manager.current_tool = Root.tool_manager.get_tool_flag("RAISE_DYKE")


func _on_dig_channel():
	Root.tool_manager.current_tool = Root.tool_manager.get_tool_flag("DIG_CHANNEL")
