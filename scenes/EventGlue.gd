extends Node

func weather_intensifies() -> void:
	Root.map_manager.water.intensity += 0.5


func baby_boom():
	Root.workers_dispatch.multiplier += 1.0
	$"../BabyBoom/Timer".start()


func baby_boom_over():
	Root.workers_dispatch.multiplier -= 1.0


func storm():
	Root.map_manager.water.intensity += 4
	Root.effects.add_storm_intensity(0.4)
	$"../Storm/Timer".start()


func storm_over():
	Root.map_manager.water.intensity -= 4
	Root.effects.add_storm_intensity(-0.4)


func severe_storm():
	Root.map_manager.water.intensity += 8
	Root.effects.add_storm_intensity(0.8)
	$"../SevereStorm/Timer".start()


func severe_storm_over():
	Root.map_manager.water.intensity -= 8
	Root.effects.add_storm_intensity(-0.8)


func tulip_craze():
	Root.resources.income_multiplier += 2.0
	$"../TulipCraze/Timer".start()

func tulip_craze_over():
	Root.resources.income_multiplier -= 2.0


func tulip_crash():
	Root.resources.income_divider += 4.0
	$"../TulipCrash/Timer".start()

func tulip_crash_over():
	Root.resources.income_divider -= 4.0
