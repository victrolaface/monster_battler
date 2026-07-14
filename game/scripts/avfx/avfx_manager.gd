extends Node

var active_effect_count: int

func queue_avfx_effect(resource: AVFXResource, target: Monster):
	var instance = resource.generate(target)
	add_child(instance)
	instance.execute()
	
	if active_effect_count == 0:
		call_deferred("emit_block_start")
	
	active_effect_count += 1
	
func emit_block_start():
	Events.on_avfx_block_start.emit()

func remove_effect(avfx_instance: AVFXInstance):
	avfx_instance.queue_free()
	active_effect_count -= 1

	if active_effect_count == 0:
		Events.on_avfx_block_end.emit()
