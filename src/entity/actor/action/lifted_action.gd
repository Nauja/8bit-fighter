class_name LiftedAction
extends ActorAction


func _do_start():
	super()
	actor.animation_player.play("lifted")
