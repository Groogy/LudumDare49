extends Node2D

var storm_intensity = 0.0 setget set_storm_intensity

var _clear_background_color := Color.cornflower
var _stormy_background_color := Color.darkslategray

func _ready() -> void:
	_update_storm_values()

func add_storm_intensity(val: float) -> void:
	set_storm_intensity(storm_intensity + val)

func set_storm_intensity(val: float) -> void:
	$Tween.interpolate_method(self, "set_background_color", storm_intensity, val, 10)
	$Tween.start()
	storm_intensity = clamp(val, 0.0, 1.0)
	_update_storm_values()


func set_background_color(val: float) -> void:
	VisualServer.set_default_clear_color(lerp(_clear_background_color, _stormy_background_color, val))

func _update_storm_values() -> void:
	if storm_intensity <= 0.0:
		$RainParticles.visible = false
		$RainParticles.amount = 0
	else:
		if not $RainParticles.visible: $RainParticles.visible = true
		var amount = lerp(0, 10000, storm_intensity)
		if $RainParticles.amount != amount:
			$RainParticles.amount = amount
			$RainParticles.initial_velocity = lerp(0, 600, storm_intensity)
