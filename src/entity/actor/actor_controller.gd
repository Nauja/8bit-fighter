# Handle inputs to control an actor
class_name ActorController
extends Node

# Controlled actor
@export_node_path("Actor") var _actor_path: NodePath
var actor: Actor:
	get = _get_actor,
	set = _set_actor

# Overrided controller
var override: ActorController:
	get = _get_override,
	set = _set_override


func _get_actor() -> Actor:
	return actor


func _set_actor(other: Actor) -> void:
	actor = other


func _get_override() -> ActorController:
	return override


func _set_override(other: ActorController) -> void:
	override = other


# Check if this controller is attached to an actor
func is_attached() -> bool:
	return actor and actor.controller == self


# Control an actor, replacing the current controller
func control(actor: Actor) -> void:
	release()
	override = actor.controller
	actor.controller = self


# Release control on current actor
func release() -> void:
	if actor:
		actor.controller = override
		actor = null
	override = null


func _ready():
	if not actor:
		actor = get_node(_actor_path)
