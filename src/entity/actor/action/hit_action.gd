class_name HitAction
extends ActorAction


func _do_start():
	super()
	if actor:
		Utils.play(actor.animation_player, "idle")
