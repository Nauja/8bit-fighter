extends ActorSheet

# Texture of the pickup
@export var texture: Texture2D


# An actor interacted with
func interact(pickup: Pickup, actor: Actor) -> bool:
	assert(false)
	return false
