class_name EquipmentSlot
extends Node2D

# Corresponding slot
@export var slot: Enums.EEquipmentSlot:
	get:
		return slot


# Equip an equipment
func equip(other: EquipmentSheet) -> bool:
	assert(false)
	return false
