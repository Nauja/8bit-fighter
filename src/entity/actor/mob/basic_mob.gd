# The basic mob has only a single Sprite and AnimationPlayer
class_name BasicMob
extends Actor

enum EBasicMobState {
	Idle,
	Move,
	Hit,
	Attack
}

var sheet: BasicMobSheet setget set_sheet, get_sheet

var sprite setget , get_sprite
var animation_player setget , get_animation_player

onready var _actions = {
	EBasicMobState.Idle: get_node("%IdleAction"),
	EBasicMobState.Move: get_node("%MoveAction"),
	EBasicMobState.Hit: get_node("%HitAction"),
	EBasicMobState.Attack: get_node("%AttackAction")
}

func set_sheet(other):
	sheet = other
	if sprite != null:
		sprite.texture = other.sprite_sheet
		sprite.hframes = other.hframes
		sprite.vframes = other.vframes

func get_sheet():
	return sheet
	
func get_sprite():
	return sprite
	
func get_animation_player():
	return animation_player
	
func _ready():
	._ready()
	sprite = get_node("%Sprite")
	animation_player = get_node("%AnimationPlayer")
	set_sheet(sheet)
	push_action(_actions[EBasicMobState.Idle])
	PlayerControllerSignals.get_player_controller(0).actor = self
	
func push_state(new_state: int) -> void:
	print(new_state)
	push_action(_actions[new_state])
