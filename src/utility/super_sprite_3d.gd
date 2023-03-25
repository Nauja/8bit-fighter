@tool
class_name SuperSprite3D
extends Sprite3D

@export var atlas: Texture2D:
	get = _get_atlas,
	set = _set_atlas


func _get_atlas() -> Texture2D:
	return atlas


func _set_atlas(val: Texture2D) -> void:
	atlas = val
	if val is AtlasTexture:
		texture = atlas.atlas
		region_enabled = true
		region_rect = atlas.region
	elif val:
		texture = val
	else:
		texture = null
		region_enabled = false


func _ready():
	texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	sorting_use_aabb_center = true
	alpha_cut = SpriteBase3D.ALPHA_CUT_OPAQUE_PREPASS
