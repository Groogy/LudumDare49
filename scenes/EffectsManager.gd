extends Node2D

var storm_intensity = 0.0 setget set_storm_intensity

var _clear_background_color := Color.cornflower
var _stormy_background_color := Color.darkslategray
var _thunder_background_color := Color.lightgoldenrod
var _current_background_color := Color()


func _ready() -> void:
	_update_storm_values()


func _physics_process(delta):
	if storm_intensity > 0.5 and $LightingTimer.is_stopped():
		$LightingTimer.wait_time = rand_range(10, 20)
		$LightingTimer.start()


func add_storm_intensity(val: float) -> void:
	set_storm_intensity(storm_intensity + val)


func set_storm_intensity(val: float) -> void:
	$StormTween.interpolate_method(self, "_update_lerped_storm_values", storm_intensity, val, 10)
	$StormTween.start()
	storm_intensity = clamp(val, 0.0, 1.0)
	_update_storm_values()


func _update_lerped_storm_values(val: float) -> void:
	_current_background_color = lerp(_clear_background_color, _stormy_background_color, val)
	VisualServer.set_default_clear_color(_current_background_color)
	if val > 0:
		if not $Wind.playing: $Wind.play()
		if not $LightRain.playing: $LightRain.play()
		if not $HeavyRain.playing: $HeavyRain.play()
		$Wind.volume_db = linear2db(lerp(0, 1.0, val))
		if val < 0.5:
			$LightRain.volume_db = linear2db(lerp(0.0, 2.0, val))
			$HeavyRain.volume_db = linear2db(0)
		else: 
			$LightRain.volume_db = linear2db(lerp(1.0, 0.0, val))
			$HeavyRain.volume_db = linear2db(lerp(0.0, 1.0, (val-0.5)/0.5))
	else:
		$Wind.stop()
		$LightRain.stop()
		$HeavyRain.stop()
	

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


func _lerp_thunder_background(val: Color) -> void:
	VisualServer.set_default_clear_color(val)


func _on_LightingTimer_timeout():
	$ThunderTween.interpolate_method(self, "_lerp_thunder_background", _thunder_background_color, _current_background_color, 1)
	$ThunderTween.start()
	$ThunderTimer.wait_time = rand_range(0.0, 3.0)
	$ThunderTimer.start()


onready var LightningSound = [
	$Thunder1, $Thunder2, $Thunder3, $Thunder4,
	$Thunder5, $Thunder6, $Thunder7, $Thunder8,
]


func _on_ThunderTimer_timeout():
	LightningSound[randi()%LightningSound.size()].play()
