extends Node


func _on_unselect():
	Root.tool_manager.current_tool = Root.tool_manager.get_tool_flag("NONE")


func _on_raise_land():
	Root.tool_manager.current_tool = Root.tool_manager.get_tool_flag("RAISE_LAND")


func _on_lower_land():
	Root.tool_manager.current_tool = Root.tool_manager.get_tool_flag("LOWER_LAND")
