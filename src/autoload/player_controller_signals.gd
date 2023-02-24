extends Node

var _get_player_controller: FuncRef

func get_player_controller(id: int) -> PlayerController:
	return _get_player_controller.call_func(id) if _get_player_controller else null
