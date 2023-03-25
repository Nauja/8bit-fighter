class_name ChaseAction
extends MoveAction

# Position to chase
var target: Vector3


func _do_start():
	super()


func _physics_process(delta):
	if not is_playing():
		return

	actor.input = Vector2(target.x - global_position.x, target.z - global_position.z).normalized()

	super(delta)
