# Controller for all basic mobs
class_name BasicMobController
extends AIController


func _find_player() -> Actor:
	for controller in PlayerControllerSignals.get_controllers():
		if controller.actor:
			return controller.actor

	return null


func _process(delta):
	if not is_attached():
		return

	if actor.can_chase():
		var player = _find_player()
		match actor.state:
			Enums.EActorState.Chase:
				if not player:
					actor.push_state(Enums.EActorState.Move)
				else:
					actor.current_action.target = player.global_position
			Enums.EActorState.Move:
				if player:
					actor.push_state(Enums.EActorState.Chase)
					actor.current_action.target = player.global_position
