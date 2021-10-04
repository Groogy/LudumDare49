extends "TooltipBase.gd"


export(Const.Tool) var tool_key := Const.Tool.NONE


func _ready():
	if tool_key == Const.Tool.NONE: return
	var source = Root.tool_manager.get_tool(tool_key)
	$Panel/Margin/Grid/MoneyValue.text = "-%d" % source.get_money_cost()
	$Panel/Margin/Grid/WorkersValue.text = "-%d" % source.get_workers_cost()

