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
		actor.animation_player.play(_idle_animation if val else _move_animation)


var _idle_animation: String:
	get = _get_idle_animation

var _move_animation: String:
	get = _get_move_animation

var _speed: int:
	get = _get_speed


func _get_idle_animation() -> String:
	return "idle"


func _get_move_animation() -> String:
	return "move"


func _get_speed() -> int:
	return actor.speed


func _do_start():
	super()
	_was_idle = false
	_is_idle = true


func get_input():
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
		actor.velocity.x = lerp(actor.velocity.x, float(dirx * _speed), actor.acceleration)
	else:
		actor.velocity.x = lerp(actor.velocity.x, float(0.0), actor.friction)
	if diry != 0:
		actor.velocity.z = lerp(actor.velocity.z, float(diry * _speed), actor.acceleration)
	else:
		actor.velocity.z = lerp(actor.velocity.z, float(0.0), actor.friction)
	_is_idle = dirx == 0 and diry == 0


func _physics_process(delta):
	if not is_playing():
		return

	get_input()
	actor.set_up_direction(Vector3.UP)
	actor.move_and_slide()
