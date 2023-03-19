extends ActorSheet

# Sprite2D sheet of the mob
@export var sprite_sheet: Texture2D:
	get = get_sprite_sheet
# Number of horizontal frames in the spritesheet
@export var hframes: int:
	get = get_hframes
# Number of vertical frames in the spritesheet
@export var vframes: int:
	get = get_vframes


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
