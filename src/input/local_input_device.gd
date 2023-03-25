class_name LocalInputDevice
extends InputDevice

@export var device: int = -2

var _is_gamepad: bool
var _jump_pressed: bool
var _attack_pressed: bool
var _interact_pressed: bool
var _left_pressed: bool
var _right_pressed: bool
var _up_pressed: bool
var _down_pressed: bool
var _direction: Vector2


# An input event occured
func on_input(event: InputEvent) -> void:
	if device != event.device:
		return

	_is_gamepad = event is InputEventJoypadButton or event is InputEventJoypadMotion

	if event.is_action("jump"):
		_jump_pressed = event.is_pressed()
	if event.is_action("attack"):
		_attack_pressed = event.is_pressed()
	if event.is_action("interact"):
		_interact_pressed = event.is_pressed()
	if event.is_action("move_left"):
		_left_pressed = event.is_pressed()
	if event.is_action("move_right"):
		_right_pressed = event.is_pressed()
	if event.is_action("move_up"):
		_up_pressed = event.is_pressed()
	if event.is_action("move_down"):
		_down_pressed = event.is_pressed()
	if event is InputEventJoypadMotion:
		if (
			event.is_action("move_left")
			or event.is_action("move_right")
			or event.is_action("move_up")
			or event.is_action("move_down")
		):
			if event.axis == 0:
				_direction.x = event.axis_value
			elif event.axis == 1:
				_direction.y = event.axis_value


func is_action_pressed(name: String) -> bool:
	match name:
		"jump":
			return _jump_pressed
		"attack":
			return _attack_pressed
		"interact":
			return _interact_pressed
		"move_left":
			return _direction.x < -0.5 if _is_gamepad else _left_pressed
		"move_right":
			return _direction.x > 0.5 if _is_gamepad else _right_pressed
		"move_up":
			return _direction.y < -0.5 if _is_gamepad else _up_pressed
		"move_down":
			return _direction.y > 0.5 if _is_gamepad else _down_pressed

	return false
