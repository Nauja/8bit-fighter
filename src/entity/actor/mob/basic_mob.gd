# The basic mob has only a single Sprite2D and AnimationPlayer
class_name BasicMob
extends Actor

enum EBasicMobState {
	Idle,
	Move,
	Hit,
	Attack
}

var sheet: BasicMobSheet:
	get = _get_sheet, set = _set_sheet

@onready var sprite: Sprite2D = %Sprite2D:
	get:
		return sprite

@onready var animation_player: AnimationPlayer = %AnimationPlayer:
	get:
		return animation_player

@onready var _actions = {
	EBasicMobState.Idle: %IdleAction,
	EBasicMobState.Move: %MoveAction,
	EBasicMobState.Hit: %HitAction,
	EBasicMobState.Attack: %AttackAction
}

func _set_sheet(other):
	sheet = other
	if sprite != null:
		sprite.texture = other.sprite_sheet
		sprite.hframes = other.hframes
		sprite.vframes = other.vframes

func _get_sheet():
	return sheet
	
func _ready():
	super()
	_set_sheet(sheet)
	push_action(_actions[EBasicMobState.Idle])
	PlayerControllerSignals.get_player_controller(0).actor = self
	
func push_state(new_state: int) -> void:
	print(new_state)
	push_action(_actions[new_state])
