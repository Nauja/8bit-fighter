class_name WeaponSlot
extends EquipmentSlot

# Weapon sheet accessors
var weapon: WeaponSheet:
	get = _get_weapon,
	set = _set_weapon

# Area for hit
@export var _area_path: NodePath
@onready var _area: Area3D = get_node(_area_path)

# Nodes
@onready var sprite: Sprite3D = %Sprite:
	get:
		return sprite


func _get_weapon() -> WeaponSheet:
	return weapon


func _set_weapon(val: WeaponSheet) -> void:
	weapon = val
	if sprite:
		sprite.atlas = val.texture if val else null


func _ready():
	weapon = weapon
	if _area:
		_area.connect("area_entered", _on_area_entered)


func equip(other: EquipmentSheet) -> bool:
	if other is WeaponSheet:
		weapon = other
		return true

	return false


func _on_area_entered(area: Area3D) -> void:
	pass
