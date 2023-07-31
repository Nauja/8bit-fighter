extends Node

@export var _filename: String = "user://user.dat"
var _data: Dictionary = default_data

const VERSION = 1

func load() -> bool:
	var file = FileAccess.open(_filename, FileAccess.READ)
	if not file:
		print("can't open ", _filename, ", error: ", FileAccess.get_open_error())
		save()
		return true
		
	var json = JSON.parse_string(file.get_line())
	if not json:
		print("could not parse save game")
		return false
		
	_data = json
	return true
	
func save() -> bool:
	var file = FileAccess.open(_filename, FileAccess.WRITE)
	if not file:
		print(FileAccess.get_open_error())
		return false
		
	file.store_line(JSON.stringify(data))
	return true
	
func delete() -> void:
	DirAccess.remove_absolute(_filename)

func reset() -> void:
	_data = default_data
	
func show() -> void:
	OS.shell_open(OS.get_user_data_dir())
	
var data: Dictionary:
	get:
		return _data
		
var _default_character_data: Dictionary:
	get:
		return {
			"level": 1
		}
		
var default_data: Dictionary:
	get:
		return {
			# Keep version for backward compatibility
			"version": VERSION,
			# Name of the player
			"name": "Unknown",
			# List of characters
			"characters": [_default_character_data]
		}
