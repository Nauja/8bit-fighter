# The basic mob has only a single Sprite2D and AnimationPlayer
class_name BasicMob
extends Actor

# Mob sheet accessor
var mob_sheet: BasicMobSheet:
	get:
		return actor_sheet
	set(val):
		actor_sheet = val

# Area to detect interactables
@onready var _interaction_area: Area3D = %InteractionArea
# Area to detect liftables
@onready var _lift_area: Area3D = %LiftArea
# Slot for lifted object
@onready var _lift_slot: Node3D = %LiftSlot
# Agent for the navigation
@onready var navigation_agent: NavigationAgent3D = %NavigationAgent:
	get:
		return navigation_agent


func _on_actor_sheet_changed() -> void:
	super()
	if mob_sheet:
		if animation_player:
			var key = animation_player.get_animation_library_list()[0]
			animation_player.remove_animation_library(key)
			animation_player.add_animation_library(key, mob_sheet.animation)
	if sprite != null:
		sprite.atlas = mob_sheet.texture if mob_sheet else null
	push_state(Enums.EActorState.Move)


func _ready():
	super()
	if _interaction_area:
		_interaction_area.connect("area_entered", _on_area_entered)
		_interaction_area.connect("area_exited", _on_area_exited)
		_interaction_area.connect("body_entered", _on_body_entered)


func attack() -> bool:
	if throw() or lift():
		return true

	if state != Enums.EActorState.Move:
		return false

	push_state(Enums.EActorState.Attack)
	return true


func lift() -> bool:
	if not can_lift():
		return false

	var action = _actions.get(Enums.EActorState.Lift)
	if not action:
		return false

	var bodies = _lift_area.get_overlapping_bodies()
	for body in bodies:
		if body == self or not body.is_liftable():
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
		perspective_enabled = false
		body.position = _lift_slot.global_position
		perspective_enabled = true
		body.add_force(
			(
				(transform.basis.x * 2.0 + transform.basis.y / 2.0)
				* max(throw_speed - lifting_speed_multiplier * body.weight, 0)
			)
		)
		body.push_state(Enums.EActorState.Thrown)

	push_state(Enums.EActorState.Move)
	return true


func _on_area_entered(area: Area3D) -> void:
	_check_interactable_entered(area)


func _on_area_exited(area: Area3D) -> void:
	_check_interactable_exited(area)


func _on_body_entered(body: Node3D) -> void:
	_check_interactable_entered(body)


func _on_body_exited(body: Node3D) -> void:
	_check_interactable_exited(body)


func _check_interactable_entered(other: Node3D) -> void:
	if other is Actor and other.is_interactable():
		add_interactable(other)


func _check_interactable_exited(other: Node3D) -> void:
	if other is Actor and other.is_interactable():
		remove_interactable(other)
