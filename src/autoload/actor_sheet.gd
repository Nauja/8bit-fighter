# Static informations about an actor
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
@export var speed: int = 120:
	get = _get_speed
@export var jump_speed: int = -180:
	get = _get_jump_speed
@export var lifting_speed: int = 60:
	get = _get_lifting_speed
@export var gravity: int = 400:
	get = _get_gravity
@export var gravity_multiplier_falling: float = 1.5
@export_range(0, 1.0) var friction: float = 0.1:
	get = _get_friction
@export_range(0, 1.0) var acceleration: float = 0.25:
	get = _get_acceleration

# Input
@export var attack_input_delay: float = 0.1
@export var interact_input_delay: float = 0.1


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


func _get_speed():
	if speed != 0 or template == null:
		return speed

	return template.speed


func _get_jump_speed():
	if jump_speed != 0 or template == null:
		return jump_speed

	return template.jump_speed


func _get_lifting_speed():
	if lifting_speed != 0 or template == null:
		return lifting_speed

	return template.lifting_speed


func _get_gravity():
	if gravity != 0 or template == null:
		return gravity

	return template.gravity


func _get_friction():
	if friction != 0 or template == null:
		return friction

	return template.friction


func _get_acceleration():
	if acceleration != 0 or template == null:
		return acceleration

	return template.acceleration


func spawn_at(pos: Vector2) -> Actor:
	if not scene:
		return null

	var o = scene.instantiate()
	o.position = pos
	o.actor_sheet = self
	return o
