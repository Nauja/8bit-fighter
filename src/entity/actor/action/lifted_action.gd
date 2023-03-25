class_name LiftedAction
extends ActorAction


func _do_start():
	super()
	Utils.play(actor.animation_player, "lifted")
	actor.perspective_enabled = false


func _do_stop():
	super()
	actor.perspective_enabled = true
