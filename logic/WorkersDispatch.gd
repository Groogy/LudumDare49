extends Node2D


const WorkerScene = preload("res://scenes/Worker.tscn")


class RequestData:
	var source: EntityPart
	var target: EntityPart
	
	func is_valid() -> bool:
		return is_instance_valid(source) and is_instance_valid(target)


var queued_requests = []


func request_workers(source: EntityPart, target: EntityPart, count: int) -> void:
	for i in count:
		var data = RequestData.new()
		data.source = source
		data.target = target
		queued_requests.push_back(data)
	$DispatchTimer.start()
	


func _on_DispatchTimer_timeout():
	if queued_requests.empty(): return
	var data = queued_requests.pop_front()
	if not data.is_valid(): return
	var worker := WorkerScene.instance()
	worker.position = Root.map_manager.map_to_world(data.source.get_cell())
	worker.target = data.target
	add_child(worker)
	$DispatchTimer.start()
