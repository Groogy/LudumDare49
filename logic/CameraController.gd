extends Camera2D


export var scrolling_speed := 10.0
export var start_pan_to_settlement := 3

var _is_dragged := false


func _ready() -> void:
	var maps = Root.map_manager
	position = maps.map_to_world(Vector2(0, maps.terrain.find_surface(0)))
	var target = maps.entities.fetch_all_parts_of("urban").front().global_position
	$StartTween.interpolate_property(self, "position", position, target, start_pan_to_settlement)
	$StartTween.start()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		_handle_drag_input(event)
	elif event is InputEventKey:
		_handle_key_input(event)


func _handle_drag_input(event: InputEventMouse) -> void:
	if event.is_action_pressed("camera_drag"):
		_is_dragged = true
	elif event.is_action_released("camera_drag"):
		_is_dragged = false
	elif _is_dragged and event is InputEventMouseMotion:
		position -= event.relative
		position.x = clamp(position.x, limit_left, limit_right)
		position.y = clamp(position.y, limit_top, limit_bottom)
		

func _handle_key_input(event: InputEventKey) -> void:
	var vector := Vector2()
	if event.is_action("camera_left"):
		vector = Vector2(-1, 0)
	elif event.is_action("camera_right"):
		vector = Vector2(1, 0)
	elif event.is_action("camera_up"):
		vector = Vector2(0, -1)
	elif event.is_action("camera_down"):
		vector = Vector2(0, 1)
	position += vector * scrolling_speed
	position.x = clamp(position.x, limit_left, limit_right)
	position.y = clamp(position.y, limit_top, limit_bottom)
