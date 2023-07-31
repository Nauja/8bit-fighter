extends Node

var _spawn_player: Callable
var _add_player: Callable
var _remove_player: Callable

func spawn_player(peer_id: int) -> Variant:
	return _spawn_player.call(peer_id)
	
func add_player(player) -> void:
	_add_player.call(player)

func remove_player(peer_id: int) -> void:
	_remove_player.call(peer_id)
