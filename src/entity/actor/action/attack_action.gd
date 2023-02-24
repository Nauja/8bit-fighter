class_name AttackAction
extends ActorAction

func _do_start():
	._do_start()
	entity.want_attack = false
	entity.animation_player.connect("animation_finished", self, "_on_animation_finished")
	entity.animation_player.play("attack")

func _physics_process(delta):
	if not is_playing() and entity.want_attack:
		entity.push_state(BasicMob.EBasicMobState.Attack)

func _on_animation_finished(name: String):
	if is_playing():
		entity.animation_player.disconnect("animation_finished", self, "_on_animation_finished")
		entity.push_state(BasicMob.EBasicMobState.Idle)
		done()
	
func can_move() -> bool:
	return false
