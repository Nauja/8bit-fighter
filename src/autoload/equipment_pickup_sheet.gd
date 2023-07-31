# Pickup sheet for equipments
class_name EquipmentPickupSheet
extends PickupSheet

# Sheet of the equipment
@export var _equipment: Resource
var equipment: EquipmentSheet:
	get:
		return _equipment


func on_interacted(interactor: Actor, pickup: Actor) -> bool:
	if not _equipment:
		return false

	var slot = interactor.get_equipment_slot(equipment.slot)
	if not slot:
		return false

	return slot.equip(equipment)
