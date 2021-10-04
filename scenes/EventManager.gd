extends Node2D


var time_since_event := 0

var show_log := false
var time_log_shown := 0.0

func _ready() -> void:
	$SevereStorm.trigger()
	$EventLog.modulate = Color.transparent


func _process(delta: float):
	if show_log:
		time_log_shown += delta
		if time_log_shown < 3:
			$EventLog.modulate.a = lerp(Color.transparent.a, Color.white.a, time_log_shown / 3.0)
		elif time_log_shown < 27:
			$EventLog.modulate = Color.white
		elif time_log_shown < 30:
			$EventLog.modulate.a = lerp(Color.white.a, Color.transparent.a, (time_log_shown-27) / 3.0)
		else:
			$EventLog.modulate = Color.transparent
			show_log = false


func get_events() -> Array:
	var events = []
	for child in get_children():
		if child is Event:
			events.push_back(child)
	return events


func trigger_random_event() -> void:
	var events := get_events()
	events[randi()%events.size()].trigger()
	time_since_event = 0


func trigger_event_log(text: String) -> void:
	$EventLog.text = text
	show_log = true
	time_log_shown = 0.0



func _on_EventTimer_timeout():
	time_since_event += 1
	if time_since_event >= 2 and randi() % (15-time_since_event) == 0:
		trigger_random_event()
