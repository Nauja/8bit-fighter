extends Resource

# Another ActorSheet used as template
export(Resource) var template setget , get_template
# Reference to the scene to be spawned
export(PackedScene) var scene setget , get_scene
# Name to display
export(String) var display_name setget , get_display_name
# Sprite sheet of the mob
export(Resource) var sprite_sheet setget , get_sprite_sheet
# Number of horizontal frames in the spritesheet
export(int) var hframes setget , get_hframes
# Number of vertical frames in the spritesheet
export(int) var vframes setget , get_vframes

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
	
func get_hframes():
	if hframes != 0 or template == null:
		return hframes
	
	return template.hframes
	
func get_vframes():
	if vframes != 0 or template == null:
		return vframes
	
	return template.vframes

