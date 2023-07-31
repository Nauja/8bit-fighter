class_name ActorNetworkState
extends EntityNetworkState

# Actor sheet
signal actor_sheet_changed

var actor_sheet: ActorSheet:
	get:
		return actor_sheet
@export var _actor_sheet_path: String:
	get:
		return _actor_sheet_path
	set(val):
		_actor_sheet_path = val
		actor_sheet = ResourceLoader.load(val)
		emit_signal("actor_sheet_changed")

@rpc("any_peer", "call_local") func _rpc_set_actor_sheet(new_path: String):
	_actor_sheet_path = new_path


func set_actor_sheet(val: ActorSheet):
	rpc("_rpc_set_actor_sheet", val.resource_path)

# State
signal state_changed

var state: Enums.EActorState:
	get:
		return state
@export var _state: Enums.EActorState:
	get:
		return _state
	set(val):
		_state = val
		state = val
		emit_signal("state_changed")

@rpc("any_peer", "call_local") func _rpc_set_state(val: int):
	_state = val


func set_state(val: int):
	rpc("_rpc_set_state", val)

func _ready():
	if not NetworkInterface.is_host:
		rpc("_rpc_request_sync")
		
@rpc("call_remote", "any_peer")
func _rpc_request_sync():
	rpc("_rpc_set_actor_sheet", _actor_sheet_path)
