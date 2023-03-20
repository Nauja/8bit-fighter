@tool
extends Camera3D


func _ready():
	look_at(Vector3.ZERO, Vector3.UP)
