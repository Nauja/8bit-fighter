class_name InputDeviceMapper
extends Node

# Scene to spawn controllers
@export var _controller_scene: PackedScene

# List of controllers
var _controllers: Array[PlayerController] = []


func _ready():
	PlayerControllerSignals._get_controller = _get_controller
	PlayerControllerSignals._get_controllers = _get_controllers
	# Spawn controllers
	for i in range(Constants.MAX_PLAYERS):
		var controller = _controller_scene.instantiate()
		controller.id = i
		_controllers.append(controller)
		call_deferred("add_child", controller)


func get_controller(device: int) -> PlayerController:
	for controller in _controllers:
		if not controller.input_device:
			continue
		if controller.device == -2:
			controller.device = device
			print("device ", device, " assigned to controller ", controller.id)
			PlayerControllerSignals.notify_controller_connected(controller.id)
		if controller.device == device:
			return controller

	return null


func device(event: InputEvent) -> int:
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		return event.device + 1

	return 0


func _unhandled_input(event: InputEvent) -> void:
	var controller = get_controller(device(event))
	if controller:
		event.device = device(event)
		controller.input_device.on_input(event)


func _get_controller(id: int):
	return _controllers[id]


func _get_controllers():
	return _controllers
