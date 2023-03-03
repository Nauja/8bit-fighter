# Root scene for loading everything
extends SubViewportContainer

# RefCounted to scene containing the home menu
@export var home_scene: PackedScene
# RefCounted to scene containing the loading screen
@export var loading_scene: PackedScene
# RefCounted to scene containing the level
@export var level_scene: PackedScene

# The root node to hide when the home menu is loaded
@export var root_node: NodePath
@onready var _root = get_node(root_node)

var _current_scene

func _ready():
	# Display the home menu when ready
	_current_scene = _load_home_scene()
	_root.queue_free()
	
func _load_scene(scene: PackedScene) -> Node:
	var instance = scene.instantiate()
	add_child(instance)
	return instance

# Load the home scene and bind events
func _load_home_scene() -> Node:
	var instance = _load_scene(home_scene)
	instance.connect("play", _on_play)
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
