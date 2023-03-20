class_name ThrownAction
extends ActorAction


func _do_start():
	super()
	actor.animation_player.play("thrown")


func _physics_process(delta):
	if not is_playing():
		return

	actor.set_up_direction(Vector3.UP)
	actor.move_and_slide()
