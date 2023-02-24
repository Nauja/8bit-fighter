class_name ActorController
extends Node2D

var actor: Actor setget set_actor, get_actor

func set_actor(other):
	actor = other
	
func get_actor():
	return actor
