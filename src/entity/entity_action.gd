class_name EntityAction
extends Node2D

# States of an action
enum EEntityActionState {
	Idle,
	WaitPlaying,
	Playing,
	Canceled,
	Done
}

# Owner entity
@export var _entity_path: NodePath
@onready var entity = get_node(_entity_path)
	
# Action state
var state: int:
	get = _get_state, set = _set_state

# If _ready has been called
var __is_ready: bool
	
func _set_state(val: int):
	state = val
	
func _get_state() -> int:
	return state
	
func _ready():
	__is_ready = true
	if state == EEntityActionState.WaitPlaying:
		start()
	
# Start the action
func start() -> void:
	if not __is_ready:
		state = EEntityActionState.WaitPlaying
	else:
		state = EEntityActionState.Playing
		_do_start()
	
# Perform the start
func _do_start() -> void:
	pass
	
# Cancel the action
func cancel() -> void:
	state = EEntityActionState.Canceled
	
# Complete the action
func done() -> void:
	state = EEntityActionState.Done

# Return if the action is playing
func is_playing() -> bool:
	return state == EEntityActionState.Playing

# Return if the action is done
func is_done() -> bool:
	return state == EEntityActionState.Done
