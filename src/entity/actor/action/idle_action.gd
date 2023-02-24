class_name IdleAction
extends ActorAction

func _do_start():
	._do_start()
	if entity:
		entity.animation_player.play("idle")
