class_name HitAction
extends ActorAction

func set_entity(other):
	.set_entity(other)
	other.play_anim("idle")
	
	
