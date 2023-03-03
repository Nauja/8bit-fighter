class_name IdleAction
extends ActorAction

func _do_start():
	super()
	if entity:
		entity.animation_player.play("idle")
