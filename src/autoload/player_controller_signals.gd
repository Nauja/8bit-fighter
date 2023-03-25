extends Node

var _get_controller: Callable
var _get_controllers: Callable

# Player controller connected
signal controller_connected(id)

# Player controller disconnected
signal controller_disconnected(id)


func get_controller(id: int) -> PlayerController:
	return _get_controller.call(id) if _get_controller else null


func get_controllers() -> Array[PlayerController]:
	return _get_controllers.call() if _get_controllers else []


func notify_controller_connected(id: int):
	emit_signal("controller_connected", id)


func notify_controller_disconnected(id: int):
	emit_signal("controller_disconnected", id)
