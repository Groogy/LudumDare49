class_name Event
extends Node

signal event_triggered

export(String, MULTILINE) var text := ""

func trigger() -> void:
	emit_signal("event_triggered")
	get_parent().trigger_event_log(text)

