extends Node


var money := 100.0
var available_workers := 0

var income := 0.0
var workers_growth := 0
var city_growth := 0.0


func _process(_delta: float) -> void:
	_update_available_workers()
	_update_income()
	_update_workers_growth()
	_update_city_growth()


func _update_available_workers() -> void:
	var parts = Root.map_manager.entities.fetch_all_parts_of("workers_provider")
	available_workers = 0.0
	for part in parts:
		available_workers += part.free_workers()


func _update_income() -> void:
	var parts = Root.map_manager.entities.fetch_all_parts_of("income_provider")
	income = 0.0
	for part in parts:
		income += part.generated_income()


func _update_workers_growth() -> void:
	var parts = Root.map_manager.entities.fetch_all_parts_of("workers_provider")
	workers_growth = 0.0
	for part in parts:
		workers_growth += part.generated_workers()


func _update_city_growth() -> void:
	city_growth = 0.0


func _on_payday():
	money += income

