class_name Actor
extends Entity

# Actor sheet accessors
@export var _actor_sheet: Resource
var actor_sheet: ActorSheet:
	get:
		return _actor_sheet
	set(val):
		_actor_sheet = val

var speed: int:
	get:
		return actor_sheet.speed

var jump_speed: int:
	get:
		return actor_sheet.jump_speed

var lifting_speed: int:
	get:
		return actor_sheet.lifting_speed

var gravity: int:
	get:
		return actor_sheet.gravity

var gravity_multiplier_falling: float:
	get:
		return actor_sheet.gravity_multiplier_falling

var friction: float:
	get:
		return actor_sheet.friction

var acceleration: float:
	get:
		return actor_sheet.acceleration

var attack_input_delay: float:
	get:
		return actor_sheet.attack_input_delay

var interact_input_delay: float:
	get:
		return actor_sheet.interact_input_delay

# Nodes
@onready var sprite: Sprite2D = %Sprite2D:
	get:
		return sprite
# Animation player
@onready var animation_player: AnimationPlayer = %AnimationPlayer:
	get:
		return animation_player
# Hold all height dependent nodes
@onready var _holder: Node2D = %Holder
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
	Enums.EActorState.Thrown: %ThrownAction
}

# Team the actor is in
@export var team: int
# Input values assigned from controller
var input: Vector2
# Height of the actor
var z: float:
	get = _get_z,
	set = _set_z
var z_speed: float

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
var is_liftable: bool = true

# Possible interactions
var interactables: Array[Node2D] = []


func _get_direction() -> Enums.EDirection:
	return direction


func _set_direction(value: Enums.EDirection) -> void:
	direction = value
	if value == Enums.EDirection.LEFT:
		scale = Vector2(1.0, -1.0)
		rotation_degrees = 180.0
	elif value == Enums.EDirection.RIGHT:
		scale = Vector2(1.0, 1.0)
		rotation_degrees = 0.0


func _get_z() -> float:
	return z


func _set_z(val: float) -> void:
	z = val
	_holder.position.y = val


# Get an equipment slot by position
func get_equipment_slot(pos: int) -> Node2D:
	return equipment_slots.get(pos)


# Return if the actor can move during this action
func can_move() -> bool:
	return _current_action.can_move() if _current_action else true


func _ready():
	_gather_equipment_slots()


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
func add_interactable(other: Node2D) -> void:
	if not other in interactables:
		interactables.append(other)


# Remove an interaction from the list
func remove_interactable(other: Node2D) -> void:
	var index = interactables.find(other)
	if index != -1:
		interactables.remove_at(index)


func _physics_process(delta):
	if _want_attack_timer > 0.0:
		_want_attack_timer -= delta
	if _want_interact_timer > 0.0:
		_want_interact_timer -= delta

	if want_interact and interact():
		want_interact = false
	elif want_attack and attack():
		want_attack = false


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
