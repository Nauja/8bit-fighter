class_name Entity
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Queue of actions to execute
var _action_queue: Array = []

# Action currently playing
var _current_action: EntityAction = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _current_action != null:
		_current_action.run(delta)
		if _current_action.is_done():
			_current_action = null

func push_action(action: EntityAction):
	_action_queue.append(action)
