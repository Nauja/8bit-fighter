class_name MoveAction
extends ActorAction

func _do_start():
	super()
	entity.animation_player.play("idle")
	
func _physics_process(delta):
	if not is_playing():
		if entity.can_move() and (entity.input.x != 0 or entity.input.y != 0):
			entity.push_state(BasicMob.EBasicMobState.Move)
		
		return
	
	if not entity.can_move() or (entity.input.x == 0 and entity.input.y == 0):
		entity.push_state(BasicMob.EBasicMobState.Idle)
		return
		
	entity.set_velocity(entity.input * 20)
	entity.set_up_direction(Vector2.UP)
	entity.move_and_slide()
	entity.velocity
	entity.sprite.set_flip_h(entity.input.x < 0)
			
