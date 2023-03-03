# Base for menus because CanvasLayer doesn't have show/hide functions
class_name Menu
extends CanvasLayer

# Control node to hide/show
@export var root_node: NodePath
@onready var _root = get_node(root_node)
