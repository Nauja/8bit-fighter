extends Menu

@export var play_button: NodePath
@onready var _play_button = get_node(play_button)

# Emitted when the play button is clicked
signal play


func _ready():
	_play_button.connect("pressed", _on_play_button_pressed)


func _on_play_button_pressed():
	emit_signal("play")
