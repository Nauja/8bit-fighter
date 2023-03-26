class_name ChaseAction
extends MoveAction

# Actor to chase
var target: Actor
# Minimum distance to be in range
var min_range: float
# Maximum distance to get out of range
var max_range: float


func _do_start():
	super()


func _physics_process(delta):
	if not is_playing():
		return

	actor.navigation_agent.set_target_position(target.global_position)
	var target_pos = actor.navigation_agent.get_next_path_position()
	#var direction = actor.global_position - target.global_position
	#var distance = direction.length
	#var wanted_distance = 0.0
	#if distance < min_range:
	#elif distance > max_range:
	#	wanted_distance = max_range
	#else:
	#	actor.input = Vector2.ZERO
	actor.input = (
		Vector2(target_pos.x - global_position.x, target_pos.z - global_position.z).normalized()
	)

	super(delta)
