class_name BasicMobSheet
extends ActorSheet

# Texture of the mob
@export var texture: Texture2D:
	get = get_texture
# Animations
@export var _animation: Resource
var animation: AnimationLibrary:
	get = get_animation


func get_texture():
	if texture != null or template == null:
		return texture

	return template.texture


func get_animation():
	if _animation != null or template == null:
		return _animation

	return template.animation
