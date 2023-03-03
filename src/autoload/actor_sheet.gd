# Static informations about an actor
extends Resource

# Another ActorSheet used as template
@export var template: Resource : get = get_template
# RefCounted to the scene to be spawned
@export var scene: PackedScene : get = get_scene
# Name to display
@export var display_name: String : get = get_display_name

func get_template():
	return template

func get_scene():
	if scene != null or template == null:
		return scene
	
	return template.scene

func get_display_name():
	if display_name != null or template == null:
		return display_name
	
	return template.display_name
