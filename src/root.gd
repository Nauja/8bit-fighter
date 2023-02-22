# Root scene for loading everything
extends ViewportContainer

# Reference to scene containing the home menu
export(PackedScene) var home_scene
# Reference to scene containing the loading screen
export(PackedScene) var loading_scene
# Reference to scene containing the level
export(PackedScene) var level_scene

# The root node to hide when the home menu is loaded
export(NodePath) var root_node
onready var _root = get_node(root_node)

var _current_scene

func _ready():
	# Display the home menu when ready
	_current_scene = _load_home_scene()
	_root.queue_free()
	
func _load_scene(scene: PackedScene) -> Node:
	var instance = scene.instance()
	add_child(instance)
	return instance

# Load the home scene and bind events
func _load_home_scene() -> Node:
	var instance = _load_scene(home_scene)
	instance.connect("play", self, "_on_play")
	return instance
	
func _load_level_scene() -> Node:
	var instance = _load_scene(level_scene)
	# do something
	return instance
	
func _remove_current_scene():
	_current_scene.queue_free()
	_current_scene = null

# Called from home menu when the play button is clicked
func _on_play():
	_remove_current_scene()
	_current_scene = _load_level_scene()
