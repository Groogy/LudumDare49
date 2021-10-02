extends Node


func _on_unselect():
	Root.tool_manager.current_tool = Root.tool_manager.get_tool_flag("NONE")


func _on_raise_land():
	Root.tool_manager.current_tool = Root.tool_manager.get_tool_flag("RAISE_LAND")


func _on_lower_land():
	Root.tool_manager.current_tool = Root.tool_manager.get_tool_flag("LOWER_LAND")


func _on_construct_flood_barrier():
	Root.tool_manager.current_tool = Root.tool_manager.get_tool_flag("FLOOD_BARRIER")


func on_construct_pipe():
	Root.tool_manager.current_tool = Root.tool_manager.get_tool_flag("PIPE")


func _on_construct_pump():
	Root.tool_manager.current_tool = Root.tool_manager.get_tool_flag("PUMP")
