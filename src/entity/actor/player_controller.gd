# Controller with player inputs
class_name PlayerController
extends ActorController

# Unique id
var id: int setget set_id, get_id

# Connected input device
export(NodePath) var _input_device_path
onready var input_device = get_node(_input_device_path)

func set_id(val: int) -> void:
	id = val
	name = "PlayerController" + str(val)
	
func get_id() -> int:
	return id

func _process(delta):
	if not actor:
		return
	
	if not input_device:
		actor.input.x = 0
		actor.input.y = 0
		actor.want_attack = false
		return
		
	if input_device.is_action_pressed("move_right"):
		actor.input.x = 1
	elif input_device.is_action_pressed("move_left"):
		actor.input.x = -1
	else:
		actor.input.x = 0
		
	if input_device.is_action_pressed("move_up"):
		actor.input.y = -1
	elif input_device.is_action_pressed("move_down"):
		actor.input.y = 1
	else:
		actor.input.y = 0
		
	actor.want_attack = input_device.is_action_pressed("attack")
