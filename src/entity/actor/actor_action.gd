class_name ActorAction
extends EntityAction

var actor: Actor:
	get:
		return entity


# Return if the actor can move during this action
func can_move() -> bool:
	return true


# Return if the actor can lift during this action
func can_lift() -> bool:
	return false
	
func _do_physics_process(delta):
	pass
	
func _physics_process(delta):
	if is_playing() and actor and actor.actor_sheet:
		_do_physics_process(delta)
