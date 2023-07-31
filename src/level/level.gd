class_name Level
extends Node3D

@export var _hero_sheet: Resource
@onready var _mobs_root: Node3D = %MobsRoot


func _ready():
	if NetworkInterface.is_host:
		PlayerControllerSignals.connect("controller_connected", _on_controller_connected)
		PlayerControllerSignals.connect("controller_disconnected", _on_controller_disconnected)


func _on_controller_connected(id: int):
	var o = _hero_sheet.spawn_at(Vector3.ZERO)
	o.name = str(id)
	PlayerControllerSignals.get_controller(id).control(o)
	_mobs_root.add_child(o, true)


func _on_controller_disconnected(id: int):
	pass
