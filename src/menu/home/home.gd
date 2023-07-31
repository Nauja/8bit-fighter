extends Menu

# Emitted when the play button is clicked
signal play


func _ready():
	set_multiplayer_authority(NetworkInterface.host_id)
	NetworkInterface.connect("state_changed", _on_state_changed)
	NetworkInterface.connect("peer_connected", _on_peer_connected)
	NetworkInterface.connect("peer_disconnected", _on_peer_disconnected)
	%PlayButton.connect("pressed", _on_play_button_pressed)
	%HostButton.connect("pressed", _on_host_button_pressed)
	%JoinButton.connect("pressed", _on_join_button_pressed)
	%LeaveButton.connect("pressed", _on_leave_button_pressed)
	%ShowProfileButton.connect("pressed", _on_show_profile_button_pressed)
	%ResetProfileButton.connect("pressed", _on_reset_profile_button_pressed)
	_on_state_changed()

func _on_state_changed():
	_update_buttons()
	
func _on_play_button_pressed():
	emit_signal.call_deferred("play")

func _on_host_button_pressed():
	NetworkInterface.host()

func _on_join_button_pressed():
	var parts = %JoinText.text.split(":")
	NetworkInterface.join(parts[0], int(parts[1]) if len(parts) > 1 else 0)

func _on_leave_button_pressed():
	NetworkInterface.close()
	
func _on_show_profile_button_pressed():
	SaveGame.show()
	
func _on_reset_profile_button_pressed():
	SaveGame.reset()
	SaveGame.save()

func _update_buttons():
	var is_connected = NetworkInterface.is_connected
	%HostButton.visible = not is_connected
	%JoinText.visible = not is_connected
	%JoinButton.visible = not is_connected
	%LeaveButton.visible = is_connected
	%PlayerSlots.visible = is_connected
	%PlayButton.visible = NetworkInterface.is_host
	
func _on_peer_connected(peer_id: int) -> void:
	if not NetworkInterface.is_host:
		return
		
	PlayerManager.spawn_player(peer_id)
	
func _on_peer_disconnected(peer_id: int) -> void:
	if not NetworkInterface.is_host:
		return

	PlayerManager.remove_player(peer_id)
