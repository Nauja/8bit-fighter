class_name Pickup
extends Actor

# Pickup sheet accessors
var pickup_sheet: PickupSheet:
	get = _get_pickup_sheet,
	set = _set_pickup_sheet

# If already picked up or not
var is_available: bool:
	get:
		return is_available


func _get_pickup_sheet() -> PickupSheet:
	return actor_sheet


func _set_pickup_sheet(val: PickupSheet) -> void:
	actor_sheet = val
	if sprite:
		sprite.texture = val.texture if val else null


func _ready():
	super()
	pickup_sheet = pickup_sheet
	is_available = true
