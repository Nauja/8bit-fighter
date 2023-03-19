class_name ThrownAction
extends ActorAction


func _do_start():
	super()
	actor.animation_player.play("thrown")


func _physics_process(delta):
	if not is_playing():
		return

	actor.z_speed += actor.gravity * (1.0 if actor.z_speed >= 0.0 else 1.0) * delta
	actor.z += actor.z_speed * delta
	if actor.z > 0.0:
		actor.z = 0.0
		actor.z_speed = 0.0
		actor.push_state(Enums.EActorState.Move)
		return

	actor.set_up_direction(Vector2.UP)
	actor.move_and_slide()
