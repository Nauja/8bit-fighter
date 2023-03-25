class_name ChestSheet
extends BasicMobSheet

# Texture when opened
@export var opened_texture: Texture2D
# Spawned reward
@export var _reward: Resource
var reward: ActorSheet:
	get:
		return _reward


# An actor interacted with
func interact(chest: Chest, actor: Actor) -> bool:
	if reward:
		var o = reward.spawn_at(chest.position)
		if o:
			chest.get_parent().add_child(o)

	return true
