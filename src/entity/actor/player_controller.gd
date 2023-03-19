# Controller with player inputs
class_name PlayerController
extends ActorController

# Unique id
var id: int:
	get = _get_id,
	set = _set_id

# Connected input device
@onready var input_device: InputDevice = %InputDevice

var _was_attack_pressed: bool
var _was_interact_pressed: bool


func _set_id(val: int) -> void:
	id = val
	name = "PlayerController" + str(val)


func _get_id() -> int:
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

	if input_device.is_action_pressed("attack"):
		actor.is_attack_pressed = true
		if not _was_attack_pressed:
			actor.want_attack = true
			_was_attack_pressed = true
	else:
		actor.is_attack_pressed = false
		_was_attack_pressed = false

	if input_device.is_action_pressed("interact"):
		actor.is_interact_pressed = true
		if not _was_interact_pressed:
			actor.want_interact = true
			_was_interact_pressed = true
	else:
		actor.is_interact_pressed = false
		_was_interact_pressed = false
