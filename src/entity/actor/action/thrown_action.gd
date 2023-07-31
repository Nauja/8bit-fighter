class_name ThrownAction
extends MoveAction


func _do_start():
	super()


func _do_physics_process(delta):
	super(delta)

	if not is_playing():
		return

	if actor.is_on_floor():
		actor.push_state(Enums.EActorState.Move)
