class_name AttackAction
extends ActorAction


func _do_start():
	super()
	actor.animation_player.connect("animation_finished", _on_animation_finished)
	actor.animation_player.play("attack")


func _on_animation_finished(name: String):
	if is_playing():
		actor.animation_player.disconnect("animation_finished", _on_animation_finished)
		actor.push_state(Enums.EActorState.Move)
		done()


func can_move() -> bool:
	return false
