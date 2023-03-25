class_name Chest
extends BasicMob

# Chest sheet accessors
var chest_sheet: ChestSheet:
	get = _get_chest_sheet,
	set = _set_chest_sheet

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


func _get_chest_sheet() -> ChestSheet:
	return actor_sheet


func _set_chest_sheet(val: ChestSheet) -> void:
	actor_sheet = val
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
