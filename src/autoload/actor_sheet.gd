# Static informations about an actor
class_name ActorSheet
extends Resource

# Another ActorSheet used as template
@export var template: Resource:
	get = _get_template
# RefCounted to the scene to be spawned
@export var scene: PackedScene:
	get = _get_scene
# Name to display
@export var display_name: String:
	get = _get_display_name

# Physics
@export var weight: float:
	get = _get_weight
@export var speed: float:
	get = _get_speed
@export var jump_speed: float:
	get = _get_jump_speed
@export var max_fall_speed: float:
	get = _get_max_fall_speed
@export var lifting_speed: float:
	get = _get_lifting_speed
@export var lifting_speed_multiplier: float:
	get = _get_lifting_speed_multiplier
@export var throw_speed: float:
	get = _get_throw_speed
@export var throw_speed_multiplier: float:
	get = _get_throw_speed_multiplier
@export var gravity_multiplier_falling: float:
	get = _get_gravity_multiplier_falling
@export var friction: float:
	get = _get_friction
@export var air_friction: float:
	get = _get_air_friction
@export var acceleration: float:
	get = _get_acceleration
# Minimum range to attack other actors
@export var attack_min_range: float:
	get = _get_attack_min_range
# Maximum range to attack other actors
@export var attack_max_range: float:
	get = _get_attack_max_range

# Input
@export var attack_input_delay: float = 0.1
@export var jump_input_delay: float = 0.1
@export var interact_input_delay: float = 0.1

# Behavior
@export var override_can_move: bool = false
@export var can_move: bool = false:
	get = _get_can_move
# If the actor can chase other actors
@export var override_can_chase: bool = false
@export var can_chase: bool = false:
	get = _get_can_chase
# If the actor can lift other actors
@export var override_can_lift: bool = false
@export var can_lift: bool = false:
	get = _get_can_lift
# If the actor can be lifted by another actor
@export var override_is_liftable: bool = false
@export var is_liftable: bool = false:
	get = _get_is_liftable
# If the actor can be interacted with by another actor
@export var override_is_interactable: bool = false
@export var is_interactable: bool = false:
	get = _get_is_interactable


func _get_template():
	return template


func _get_scene():
	if scene != null or template == null:
		return scene

	return template.scene


func _get_display_name():
	if display_name != null or template == null:
		return display_name

	return template.display_name


func _get_weight():
	if weight != 0 or template == null:
		return weight

	return template.weight


func _get_speed():
	if speed != 0 or template == null:
		return speed

	return template.speed


func _get_jump_speed():
	if jump_speed != 0 or template == null:
		return jump_speed

	return template.jump_speed


func _get_max_fall_speed():
	if max_fall_speed != 0 or template == null:
		return max_fall_speed

	return template.max_fall_speed


func _get_lifting_speed():
	if lifting_speed != 0 or template == null:
		return lifting_speed

	return template.lifting_speed


func _get_lifting_speed_multiplier():
	if lifting_speed_multiplier != 0 or template == null:
		return lifting_speed_multiplier

	return template.lifting_speed_multiplier


func _get_throw_speed():
	if throw_speed != 0 or template == null:
		return throw_speed

	return template.throw_speed


func _get_throw_speed_multiplier():
	if throw_speed_multiplier != 0 or template == null:
		return throw_speed_multiplier

	return template.throw_speed_multiplier


func _get_gravity_multiplier_falling():
	if gravity_multiplier_falling != 0 or template == null:
		return gravity_multiplier_falling

	return template.gravity_multiplier_falling


func _get_friction():
	if friction != 0 or template == null:
		return friction

	return template.friction


func _get_air_friction():
	if air_friction != 0 or template == null:
		return air_friction

	return template.air_friction


func _get_acceleration():
	if acceleration != 0 or template == null:
		return acceleration

	return template.acceleration


func _get_attack_min_range():
	if attack_min_range != 0 or template == null:
		return attack_min_range

	return template.attack_min_range


func _get_attack_max_range():
	if attack_max_range != 0 or template == null:
		return attack_max_range

	return template.attack_max_range


func _get_can_move():
	if override_can_move or template == null:
		return can_move

	return template.can_move


func _get_can_chase():
	if override_can_chase or template == null:
		return can_chase

	return template.can_chase


func _get_can_lift():
	if override_can_lift or template == null:
		return can_lift

	return template.can_lift


func _get_is_liftable():
	if override_is_liftable or template == null:
		return is_liftable

	return template.is_liftable


func _get_is_interactable():
	if override_is_interactable or template == null:
		return is_interactable

	return template.is_interactable


func spawn_at(pos: Vector3) -> Actor:
	if not scene:
		return null

	var o = scene.instantiate()
	o.position = pos
	o.actor_sheet = self
	return o
