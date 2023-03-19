class_name HitAction
extends ActorAction


func _do_start():
	super()
	if actor:
		actor.animation_player.play("idle")
