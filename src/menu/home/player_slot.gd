extends Node

enum EState { DISCONNECTED, CONNECTED, READY }

var state: EState:
	get:
		return state
		
func set_player_profile(data: Dictionary) -> void:
	pass
