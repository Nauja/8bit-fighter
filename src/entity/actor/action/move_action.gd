class_name MoveAction
extends ActorAction

# If the actor is not moving
var _was_idle: bool
var _is_idle: bool:
	get = _get_is_idle,
	set = _set_is_idle


func _get_is_idle() -> bool:
	return _is_idle


func _set_is_idle(val: bool) -> void:
	_is_idle = val
	if _was_idle != val:
		_was_idle = val
		Utils.play(actor.animation_player, _idle_animation if val else _move_animation)


var _idle_animation: String:
	get = _get_idle_animation

var _move_animation: String:
	get = _get_move_animation

var _speed: float:
	get = _get_speed

var _jump_speed: float:
	get = _get_jump_speed


func _get_idle_animation() -> String:
	return "idle"


func _get_move_animation() -> String:
	return "move"


func _get_speed() -> float:
	return actor.speed


func _get_jump_speed() -> float:
	return actor.jump_speed


func can_lift() -> bool:
	return true


func _do_start():
	super()
	_was_idle = false
	_is_idle = true


func get_input(delta: float):
	var dirx = 0
	var diry = 0
	if actor.input.x > 0:
		dirx = 1
	if actor.input.x < 0:
		dirx = -1
	if actor.input.y > 0:
		diry = 1
	if actor.input.y < 0:
		diry = -1
	if dirx != 0:
		actor.direction = Enums.EDirection.RIGHT if dirx > 0 else Enums.EDirection.LEFT
	if dirx != 0:
		actor.velocity.x = lerp(actor.velocity.x, float(dirx * _speed), actor.acceleration * delta)
	else:
		actor.velocity.x = lerp(
			actor.velocity.x,
			float(0.0),
			(actor.friction if actor.is_on_ground else actor.air_friction) * delta
		)
	if diry != 0:
		actor.velocity.z = lerp(actor.velocity.z, float(diry * _speed), actor.acceleration * delta)
	else:
		actor.velocity.z = lerp(
			actor.velocity.z,
			float(0.0),
			(actor.friction if actor.is_on_ground else actor.air_friction) * delta
		)
	_is_idle = dirx == 0 and diry == 0


func _do_physics_process(delta):
	get_input(delta)
	actor.velocity.y -= Constants.GRAVITY * actor.gravity_multiplier * delta
	actor.velocity.y = max(actor.velocity.y, actor.max_fall_speed)
	actor.set_up_direction(Vector3.UP)
	actor.move_and_slide()

	actor.is_on_ground = actor.is_on_floor()
	if actor.is_on_ground:
		if actor.is_jumping:
			# Stop jump
			actor.is_jumping = false
			actor.gravity_multiplier = 1

	if actor.is_jumping:
		if not actor.is_jump_pressed or actor.velocity.y <= 0:
			# Increase gravity when falling
			actor.gravity_multiplier = actor.gravity_multiplier_falling

	if actor.want_jump:
		jump()


func jump() -> void:
	if actor.is_on_ground:
		actor.want_jump = false
		actor.add_force(Vector3.UP * _jump_speed)
		actor.is_jumping = true
		actor.is_on_ground = false
