class_name Player
extends Node

# Unique id
@export var id: int
# Associated peer id
@export var peer_id: int

func _ready():
	if NetworkInterface.state == Enums.ENetworkInterfaceState.JOINED:
		_send_player_profile()

	PlayerManager.add_player(self)

func _send_player_profile():
	rpc_id(NetworkInterface.host_id, "_rpc_send_player_profile", {})
	
@rpc("any_peer")
func _rpc_send_player_profile(data: Dictionary):
	print("player profile received from ", multiplayer.get_remote_sender_id())
