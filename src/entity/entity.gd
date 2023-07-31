class_name Entity
extends CharacterBody3D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Queue of actions to execute
var _action_queue: Array[EntityAction] = []

# Action currently playing
@export var current_action: EntityAction:
	get:
		return current_action


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_action and current_action.is_done():
		current_action = null


func push_action(action: EntityAction):
	if current_action:
		current_action.cancel()
		current_action._do_stop()

	_action_queue = []
	current_action = action

	if action:
		_action_queue.append(action)
		action.start()
