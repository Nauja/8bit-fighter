class_name ActorController
extends Node2D

var actor: Actor:
	get = _get_actor, set = _set_actor

func _set_actor(other):
	actor = other
	
func _get_actor():
	return actor
