extends Node

# Port for hosting the local server
@export var host_port: int = 6900

signal state_changed
signal peer_connected
signal peer_disconnected

# State of the interface
var state: Enums.ENetworkInterfaceState:
	get: return state
	set(val):
		print("NetworkInterface state ", state, " -> ", val)
		state = val
		emit_signal("state_changed")
# Peer for hosting the local server
var _host_peer: ENetMultiplayerPeer
# Peer for joining a remote server
var _join_peer: ENetMultiplayerPeer

var is_host: bool:
	get:
		return state == Enums.ENetworkInterfaceState.HOSTING

var is_join: bool:
	get:
		return state == Enums.ENetworkInterfaceState.JOINED

var is_connected: bool:
	get:
		return state == Enums.ENetworkInterfaceState.HOSTING or state == Enums.ENetworkInterfaceState.JOINED

var host_id: int:
	get:
		return 1
		
var peer: ENetMultiplayerPeer:
	get:
		return _host_peer if state == Enums.ENetworkInterfaceState.HOSTING else _join_peer
		
func _ready():
	multiplayer.server_relay = false
	multiplayer.connect("peer_connected", _on_peer_connected)
	multiplayer.connect("peer_disconnected", _on_peer_disconnected)
	multiplayer.connect("server_disconnected", _on_server_disconnected)
	state = Enums.ENetworkInterfaceState.CLOSED
	host()
	
# Open a local server	
func host() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(host_port)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		print("can't start local server")
		return
	_host_peer = peer
	multiplayer.multiplayer_peer = peer
	if state == Enums.ENetworkInterfaceState.CLOSED:
		state = Enums.ENetworkInterfaceState.HOSTING
	print("local server started")
	
# Join an host
func join(address: String, port: int = 0) -> void:
	print("join server ", address, ":", port)
	state = Enums.ENetworkInterfaceState.JOINING
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(address, host_port if port == 0 else port)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		print("failed to start multiplayer client.")
		return
	_join_peer = peer
	multiplayer.multiplayer_peer = peer
	print("connecting to server")
	state = Enums.ENetworkInterfaceState.JOINING
	
func close() -> void:
	multiplayer.multiplayer_peer.close()
	_host_peer = null
	_join_peer = null
	state = Enums.ENetworkInterfaceState.CLOSED
	print("closed connection")
	
func _on_peer_connected(peer_id: int) -> void:
	if state == Enums.ENetworkInterfaceState.JOINING:
		print("connected to server")
		state = Enums.ENetworkInterfaceState.JOINED
	emit_signal("peer_connected", peer_id)
	
func _on_peer_disconnected(peer_id: int) -> void:
	print("peer disconnected ", peer_id, " is host ", is_host)
	emit_signal("peer_disconnected", peer_id)

func _on_server_disconnected() -> void:
	print("server disconnected")
	
