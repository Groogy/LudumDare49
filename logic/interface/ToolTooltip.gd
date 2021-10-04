extends "TooltipBase.gd"


func _process(_delta: float) -> void:
	var t = get_parent()
	if t.visible:
		var label = $Panel/Margin/Label
		var text = t.generate_tooltip()
		if text.empty():
			visible = false
		else:
			label.text = text
			visible = true

