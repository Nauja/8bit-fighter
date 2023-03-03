class_name Actor
extends Entity

# Team the actor is in
@export var team: int
# Input values assigned from controller
var input: Vector2

var want_attack: bool

# Return if the actor can move during this action
func can_move() -> bool:
	return _current_action.can_move() if _current_action else true
