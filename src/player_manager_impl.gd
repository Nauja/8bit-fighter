class_name PlayerManagerImpl
extends Node

# Scene to spawn players
@export var _player_scene: PackedScene
# Where to spawn players
@export var _player_root_path: NodePath
@onready var player_root = get_node(_player_root_path)
# Players by ids
var _players: Dictionary = {}

func _ready():
	PlayerManager._spawn_player = _spawn_player
	PlayerManager._add_player = _add_player
	PlayerManager._remove_player = _remove_player

func _spawn_player(peer_id: int) -> Variant:
	var player = _player_scene.instantiate()
	player.set_multiplayer_authority(peer_id)
	player_root.add_child(player)
	return player

func _add_player(player: Player) -> void:
	print("add_player ", player)

func _remove_player(peer_id: int):
	pass
