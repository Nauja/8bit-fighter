# Static informations about a mob
extends Resource

# Another MobSheet used as template
export(Resource) var template setget , get_template
# Reference to the scene to be spawned
export(PackedScene) var scene setget , get_scene
# Name to display
export(String) var display_name setget , get_display_name
# Sprite sheet of the mob
export(Resource) var sprite_sheet setget , get_sprite_sheet

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

func get_sprite_sheet():
	if sprite_sheet != null or template == null:
		return sprite_sheet
	
	return template.sprite_sheet
	
