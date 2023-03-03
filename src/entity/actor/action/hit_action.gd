class_name HitAction
extends ActorAction

func _do_start():
	super()
	if entity:
		entity.animation_player.play("idle")
