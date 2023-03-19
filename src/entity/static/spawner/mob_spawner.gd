class_name MobSpawner
extends Node2D

@export var root_node: NodePath
@onready var _root = get_node(root_node)

# Sheet of the mob to spawn
@export var mob_sheet: Resource


func _ready():
	var mob = mob_sheet.scene.instantiate()
	mob.mob_sheet = mob_sheet
	mob.position = position

	_root.call_deferred("add_child", mob)
