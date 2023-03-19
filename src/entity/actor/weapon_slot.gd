class_name WeaponSlot
extends EquipmentSlot

# Weapon sheet accessors
var weapon: WeaponSheet:
	get = _get_weapon,
	set = _set_weapon

# Area for hit
@export var _area_path: NodePath
@onready var _area: Area2D = get_node(_area_path)

# Nodes
@onready var sprite: Sprite2D = %Sprite2D:
	get:
		return sprite


func _get_weapon() -> WeaponSheet:
	return weapon


func _set_weapon(val: WeaponSheet) -> void:
	weapon = val
	if sprite:
		sprite.texture = val.texture if val else null


func _ready():
	weapon = weapon
	if _area:
		_area.connect("area_entered", _on_area_entered)


func equip(other: EquipmentSheet) -> bool:
	if other is WeaponSheet:
		weapon = other
		return true

	return false


func _on_area_entered(area: Area2D) -> void:
	print(name, " entered ", area)
