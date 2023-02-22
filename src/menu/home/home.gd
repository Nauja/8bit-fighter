extends Menu

export(NodePath) var play_button
onready var _play_button = get_node(play_button)

# Emitted when the play button is clicked
signal play

func _ready():
	_play_button.connect("pressed", self, "_on_play_button_pressed")

func _on_play_button_pressed():
	emit_signal("play")
