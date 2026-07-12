extends Node

func queue_avfx_effect(resource: AVFXResource, target: Monster):
	var instance = resource.generate(target)
	add_child(instance)
	instance.execute()
	
