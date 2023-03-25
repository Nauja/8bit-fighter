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
