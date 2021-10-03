extends Node


onready var money_value := $"../MoneyValue"
onready var workers_value := $"../WorkersValue"
onready var income_value := $"../IncomeValue"
onready var workers_growth_value := $"../WorkersGrowthValue"

func _process(_delta: float) -> void:
	money_value.text = str(Root.resources.money)
	workers_value.text = str(Root.resources.available_workers)
	
	income_value.text = "+%.1f" % Root.resources.income
	workers_growth_value.text = "+%d" % Root.resources.workers_growth
	
