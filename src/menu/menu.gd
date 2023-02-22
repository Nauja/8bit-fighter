# Base for menus because CanvasLayer doesn't have show/hide functions
class_name Menu
extends CanvasLayer

# Control node to hide/show
export(NodePath) var root_node
onready var _root = get_node(root_node)

func hide():
	_root.hide()
	
func show():
	_root.show()
