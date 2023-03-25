extends Node


static func play(animation_player: AnimationPlayer, track: String) -> void:
	if animation_player:
		animation_player.play(track)
