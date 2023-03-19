# The basic mob has only a single Sprite2D and AnimationPlayer
class_name BasicMob
extends Actor

# Mob sheet accessor
var mob_sheet: BasicMobSheet:
	get = _get_mob_sheet,
	set = _set_mob_sheet

# Area to detect interactables
@onready var _interaction_area: Area2D = %InteractionArea
# Area to detect liftables
@onready var _lift_area: Area2D = %LiftArea
# Slot for lifted object
@onready var _lift_slot: Node2D = %LiftSlot


func _get_mob_sheet() -> BasicMobSheet:
	return actor_sheet


func _set_mob_sheet(val: BasicMobSheet) -> void:
	actor_sheet = val
	if val:
		name = val.display_name
	if sprite != null:
		sprite.texture = val.sprite_sheet if val else null


func _ready():
	super()
	mob_sheet = mob_sheet
	assert(mob_sheet)
	if _interaction_area:
		_interaction_area.connect("area_entered", _on_area_entered)
		_interaction_area.connect("area_exited", _on_area_exited)
		_interaction_area.connect("body_entered", _on_body_entered)
	push_action(_actions[Enums.EActorState.Move])
	PlayerControllerSignals.get_player_controller(0).actor = self


func attack() -> bool:
	if throw() or lift():
		return true

	if state != Enums.EActorState.Move:
		return false

	push_state(Enums.EActorState.Attack)
	return true


func lift() -> bool:
	var action = _actions.get(Enums.EActorState.Lift)
	if not action:
		return false

	if state != Enums.EActorState.Move:
		return false

	var bodies = _lift_area.get_overlapping_bodies()
	for body in bodies:
		if body == self:
			continue

		action.target = body
		push_state(Enums.EActorState.Lift)
		body.push_state(Enums.EActorState.Lifted)
		return true

	return false


func throw() -> bool:
	if state != Enums.EActorState.Lift:
		return false

	var action = _actions.get(Enums.EActorState.Lift)
	if action:
		var body = action.target
		body.get_parent().remove_child(body)
		get_parent().add_child(body)
		body.position = position
		body.z = _lift_slot.position.y
		body.z_speed = -10.0
		body.velocity = Vector2(400.0, 0.0)
		body.push_state(Enums.EActorState.Thrown)

	push_state(Enums.EActorState.Move)
	return true


func _on_area_entered(area: Area2D) -> void:
	print(name, " entered ", area)
	if area.is_in_group("interactable"):
		add_interactable(area)


func _on_area_exited(area: Area2D) -> void:
	print(name, " exited ", area)
	if area.is_in_group("interactable"):
		remove_interactable(area)


func _on_body_entered(body: Node2D) -> void:
	print(name, " entered ", body)
