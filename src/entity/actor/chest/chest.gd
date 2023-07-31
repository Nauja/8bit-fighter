class_name Chest
extends BasicMob

# Chest sheet accessors
var chest_sheet: ChestSheet:
	get:
		return actor_sheet
	set(val):
		actor_sheet = val

var closed_texture: Texture2D:
	get:
		return chest_sheet.texture

var opened_texture: Texture2D:
	get:
		return chest_sheet.opened_texture

# If chest is open
var is_open: bool:
	get = _get_is_open,
	set = _set_is_open


func _on_actor_sheet_changed() -> void:
	super()
	is_open = is_open


func _get_is_open() -> bool:
	return is_open


func _set_is_open(val: bool) -> void:
	is_open = val
	if sprite:
		sprite.atlas = ((opened_texture if val else closed_texture) if chest_sheet else null)


func _ready():
	super()
	is_open = false
