class_name Actor
extends Entity

# Actor sheet accessors
@export var _actor_sheet: Resource
var actor_sheet: ActorSheet:
	get:
		return _actor_sheet
	set(val):
		_actor_sheet = val

var weight: float:
	get:
		return actor_sheet.weight

var speed: float:
	get:
		return actor_sheet.speed

var jump_speed: float:
	get:
		return actor_sheet.jump_speed

var max_fall_speed: float:
	get:
		return actor_sheet.max_fall_speed

var lifting_speed: float:
	get:
		return actor_sheet.lifting_speed

var lifting_speed_multiplier: float:
	get:
		return actor_sheet.lifting_speed_multiplier

var throw_speed: float:
	get:
		return actor_sheet.throw_speed

var throw_speed_multiplier: float:
	get:
		return actor_sheet.throw_speed_multiplier

var gravity: float:
	get:
		return actor_sheet.gravity

var gravity_multiplier_falling: float:
	get:
		return actor_sheet.gravity_multiplier_falling

var friction: float:
	get:
		return weight * gravity

var air_friction: float:
	get:
		return actor_sheet.air_friction

var acceleration: float:
	get:
		return actor_sheet.acceleration

var attack_input_delay: float:
	get:
		return actor_sheet.attack_input_delay

var jump_input_delay: float:
	get:
		return actor_sheet.jump_input_delay

var interact_input_delay: float:
	get:
		return actor_sheet.interact_input_delay


func can_move() -> bool:
	return actor_sheet.can_move and (current_action.can_move() if current_action else true)


func can_chase() -> bool:
	return actor_sheet.can_chase


func can_lift() -> bool:
	return actor_sheet.can_lift and (current_action.can_lift() if current_action else true)


func is_liftable() -> bool:
	return actor_sheet.is_liftable


# Nodes
@onready var shadow: SuperSprite3D = %Shadow:
	get:
		return shadow
@onready var sprite: SuperSprite3D = %Sprite:
	get:
		return sprite
# Node used to fake perspective for the sprite
@onready var _sprite_perspective: Node3D = %SpritePerspective
# Animation player
@onready var animation_player: AnimationPlayer = %AnimationPlayer:
	get:
		return animation_player
# Equipment slots
@export var _equipment_slot_paths: Array[NodePath]
var equipment_slots = {}
# Possible actions
@onready var _actions = {
	Enums.EActorState.Move: %MoveAction,
	Enums.EActorState.Hit: %HitAction,
	Enums.EActorState.Attack: %AttackAction,
	Enums.EActorState.Lift: %LiftAction,
	Enums.EActorState.Lifted: %LiftedAction,
	Enums.EActorState.Thrown: %ThrownAction,
	Enums.EActorState.Chase: %ChaseAction
}

# Team the actor is in
@export var team: int
# Input values assigned from controller
var input: Vector2
# Controller for this actor
var controller: ActorController
# Does the actor want to jump, including a slight delay
var _want_jump_timer: float
var want_jump:
	get:
		return _want_jump_timer > 0.0
	set(value):
		_want_jump_timer = jump_input_delay if value else 0.0
# Is the jump input pressed this frame
var is_jump_pressed: bool
# Is the actor currently jumping
var is_jumping: bool
# Current state
var state: Enums.EActorState:
	get:
		return state

# Does the actor want to do an attack, including a slight delay
var _want_attack_timer: float
var want_attack:
	get:
		return _want_attack_timer > 0.0
	set(value):
		_want_attack_timer = attack_input_delay if value else 0.0
# Is the attack input pressed this frame
var is_attack_pressed: bool
# Does the actor want to do an interact, including a slight delay
var _want_interact_timer: float
var want_interact:
	get:
		return _want_interact_timer > 0.0
	set(value):
		_want_interact_timer = interact_input_delay if value else 0.0
# Is the interact input pressed this frame
var is_interact_pressed: bool
# Facing direction
var direction: Enums.EDirection:
	get = _get_direction,
	set = _set_direction
# If the actor is lifting an object
var is_lifting: bool
# Is the actor on ground, including a slight delay
var is_on_ground_timer: float
var is_on_ground: bool:
	get:
		return is_on_ground_timer > 0.0
	set(value):
		is_on_ground_timer = 0.1 if value else 0.0
# Gravity multiplier for when falling
var gravity_multiplier: float = 17
var movement_force: Vector3 = Vector3.ZERO
var applied_forces: Vector3 = Vector3.ZERO

var perspective_enabled: bool:
	get = _get_perspective_enabled,
	set = _set_perspective_enabled

# Possible interactions
var interactables: Array[Node3D] = []


func _get_direction() -> Enums.EDirection:
	return direction


func _set_direction(value: Enums.EDirection) -> void:
	direction = value
	_update_perspective()


# Get an equipment slot by position
func get_equipment_slot(pos: int) -> Node3D:
	return equipment_slots.get(pos)


func _get_perspective_enabled() -> bool:
	return perspective_enabled


func _set_perspective_enabled(val: bool) -> void:
	perspective_enabled = val
	_update_perspective()


func add_force(force: Vector3) -> void:
	velocity += force


func _update_perspective() -> void:
	if direction == Enums.EDirection.LEFT:
		rotation_degrees = Vector3(0.0, 180.0, 0.0)
		_sprite_perspective.rotation_degrees = Vector3(
			45.0 if perspective_enabled else 0.0, 0.0, 0.0
		)
	elif direction == Enums.EDirection.RIGHT:
		rotation_degrees = Vector3.ZERO
		_sprite_perspective.rotation_degrees = Vector3(
			-45.0 if perspective_enabled else 0.0, 0.0, 0.0
		)


func _ready():
	_gather_equipment_slots()
	direction = Enums.EDirection.RIGHT
	perspective_enabled = true
	if not controller:
		controller = %Controller
	if controller:
		controller.actor = self


# Build the list of equipment slots
func _gather_equipment_slots() -> void:
	equipment_slots = {}
	for slot_path in _equipment_slot_paths:
		var slot = get_node(slot_path)
		if slot:
			equipment_slots[slot.slot] = slot


# Equip something
func equip(other: Resource) -> void:
	var slot = get_equipment_slot(other.slot)
	print(name, " equip ", other, " slot ", slot)
	if slot:
		slot.equip(other)


# Add a possible interaction to the list
func add_interactable(other: Node3D) -> void:
	if not other in interactables:
		interactables.append(other)


# Remove an interaction from the list
func remove_interactable(other: Node3D) -> void:
	var index = interactables.find(other)
	if index != -1:
		interactables.remove_at(index)


func _physics_process(delta):
	if _want_jump_timer > 0.0:
		_want_jump_timer -= delta
	if _want_attack_timer > 0.0:
		_want_attack_timer -= delta
	if _want_interact_timer > 0.0:
		_want_interact_timer -= delta

	if want_interact and interact():
		want_interact = false
	elif want_attack and attack():
		want_attack = false

	if perspective_enabled:
		shadow.visible = true
		var space_state = get_world_3d().direct_space_state
		var result = space_state.intersect_ray(
			PhysicsRayQueryParameters3D.create(
				global_position, -transform.basis.y * 100.0, 8, [self]
			)
		)
		if result:
			shadow.global_position = result["position"]
	else:
		shadow.visible = false


# Try to interact with a nearby object
func interact() -> bool:
	if state != Enums.EActorState.Move:
		return false

	if len(interactables) == 0:
		return false

	var interactable = interactables[0]
	if not interactable.has_method("interact"):
		return false

	want_interact = false
	return interactable.interact(self)


# Try to perform an attack
func attack() -> bool:
	return false


func push_state(new_state: int) -> void:
	state = new_state
	push_action(_actions[new_state])
