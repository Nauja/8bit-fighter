class_name MobSpawner
extends Node2D

export(NodePath) var root_node
onready var _root = get_node(root_node)

# Sheet of the mob to spawn
export(Resource) var mob_sheet

func _ready():
	var mob = mob_sheet.scene.instance()
	mob.name = mob_sheet.display_name
	mob.sheet = mob_sheet
	mob.position = position
	
	_root.call_deferred("add_child", mob)
