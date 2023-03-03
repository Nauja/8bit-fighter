class_name GameInstance
extends Node2D

@export var _player_controller_scene: PackedScene
var _controllers: Array = []

func _ready():
	PlayerControllerSignals._get_player_controller = _get_player_controller
	
	for i in range(Constants.MAX_PLAYERS):
		var controller = _player_controller_scene.instantiate()
		controller.id = i
		_controllers.append(controller)
		call_deferred("add_child", controller)

func _get_player_controller(id: int):
	return _controllers[id]
