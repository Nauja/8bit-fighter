class_name LocalInputDevice
extends InputDevice


func is_action_pressed(name: String) -> bool:
	return Input.is_action_pressed(name)
