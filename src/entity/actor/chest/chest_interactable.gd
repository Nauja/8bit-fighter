# Interactable component of a chest
class_name ChestInteractable
extends Area3D

# Owner
@export var _chest_path: NodePath
@onready var _chest: Chest = get_node(_chest_path)

var _destroy_timer: float = -1


# An actor interacts with this
func interact(actor: Actor) -> bool:
	if not _chest.chest_sheet or _chest.is_open:
		return false

	if not _chest.chest_sheet.interact(_chest, actor):
		return false

	_chest.is_open = true
	_destroy_timer = 0.25
	return true


func _physics_process(delta):
	if _destroy_timer > 0.0:
		_destroy_timer -= delta
		if _destroy_timer <= 0.0:
			_chest.queue_free()
