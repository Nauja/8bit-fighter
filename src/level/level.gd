class_name Level
extends Node3D

@export var _hero_sheet: Resource


func _ready():
	PlayerControllerSignals.connect("controller_connected", _on_controller_connected)
	PlayerControllerSignals.connect("controller_disconnected", _on_controller_disconnected)


func _on_controller_connected(id: int):
	var o = _hero_sheet.spawn_at(Vector3.ZERO)
	PlayerControllerSignals.get_controller(id).control(o)
	add_child(o)


func _on_controller_disconnected(id: int):
	pass
