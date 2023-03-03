extends Resource

# Another ActorSheet used as template
@export var template: Resource : get = get_template
# RefCounted to the scene to be spawned
@export var scene: PackedScene : get = get_scene
# Name to display
@export var display_name: String : get = get_display_name
# Sprite2D sheet of the mob
@export var sprite_sheet: Texture2D : get = get_sprite_sheet
# Number of horizontal frames in the spritesheet
@export var hframes: int : get = get_hframes
# Number of vertical frames in the spritesheet
@export var vframes: int : get = get_vframes

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

