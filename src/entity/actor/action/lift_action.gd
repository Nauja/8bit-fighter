class_name LiftAction
extends MoveAction

# Slot for lifted objects
@export var _lift_slot_path: NodePath
@onready var _lift_slot: Node3D = get_node(_lift_slot_path)
# Lifted actor
var target: Actor


func _get_idle_animation() -> String:
	return "lift_idle"


func _get_move_animation() -> String:
	return "lift_move"


func _get_speed() -> float:
	return max(super() - actor.lifting_speed_multiplier * (target.weight if target else 0), 0)


func _get_jump_speed() -> float:
	return max(super() - actor.lifting_speed_multiplier * (target.weight if target else 0), 0)


func _do_start():
	super()
	assert(target)
	target.get_parent().remove_child(target)
	_lift_slot.add_child(target)
	target.position = Vector3.ZERO
