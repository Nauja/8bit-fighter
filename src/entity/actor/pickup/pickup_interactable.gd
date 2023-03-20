# Handle interaction with the pickup
class_name PickupInteractable
extends Area3D

# Owner
@export var _owner_path: NodePath
@onready var _owner: Pickup = get_node(_owner_path)


# An actor interacts with
func interact(actor: Actor) -> bool:
	if not _owner.pickup_sheet or not _owner.is_available:
		return false

	if not _owner.pickup_sheet.interact(_owner, actor):
		return false

	_owner.is_available = false
	_owner.queue_free()
	return true
