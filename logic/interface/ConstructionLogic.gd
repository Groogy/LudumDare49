extends Node


func _unhandled_input(event):
	if event.is_action_pressed("game_unselect"):
		_on_unselect()
		get_tree().set_input_as_handled()


func _on_unselect():
	Root.tool_manager.current_tool = Const.Tool.NONE


func _on_raise_land():
	Root.tool_manager.current_tool = Const.Tool.RAISE_LAND


func _on_lower_land():
	Root.tool_manager.current_tool = Const.Tool.LOWER_LAND


func _on_construct_flood_barrier():
	Root.tool_manager.current_tool = Const.Tool.FLOOD_BARRIER


func on_construct_pipe():
	Root.tool_manager.current_tool = Const.Tool.PIPE


func _on_construct_pump():
	Root.tool_manager.current_tool = Const.Tool.PUMP


func _on_destroy():
	Root.tool_manager.current_tool = Const.Tool.DESTROY


func _on_Tulips_pressed():
	Root.tool_manager.current_tool = Const.Tool.TULIPS
