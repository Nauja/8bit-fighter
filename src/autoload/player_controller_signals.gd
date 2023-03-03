extends Node

var _get_player_controller: Callable

func get_player_controller(id: int) -> PlayerController:
	return _get_player_controller.call(id) if _get_player_controller else null
