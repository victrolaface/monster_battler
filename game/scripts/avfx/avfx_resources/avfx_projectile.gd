class_name AVFXProjectile extends AVFXResource

@export var sprite: Texture2D

func _do(instance: AVFXInstance):
	Events.on_avfx_sfx_projectile.emit(instance, sprite)
