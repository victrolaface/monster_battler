extends Node

var active_effect_count: int
var effect_group_queue: Array[Node]
var current_effect_group: Node
var active: bool

func _process(_delta: float) -> void:
	if active and current_effect_group == null:
		if effect_group_queue.size() == 0:
			Events.on_avfx_block_end.emit()
			active = false
		else:
			current_effect_group = effect_group_queue.pop_front()
			active_effect_count = current_effect_group.get_children().size()
		if active_effect_count > 0:
			for afvx_instance in current_effect_group.get_children():
				afvx_instance.execute()
		else:
			current_effect_group = null
	
func queue_avfx_effect_group(resources: Array[AVFXResource], monster: Monster):
	active = true
	var group = Node.new()
	add_child(group)
	for resource in resources:
		var target = monster if resource.target_self else MonsterController.get_monster_opponent(monster)
		var instance = resource.generate(target, monster)
		group.add_child(instance)
		instance.name = resource.get_script().get_global_name()
	effect_group_queue.push_back(group)
	
func emit_block_start():
	Events.on_avfx_block_start.emit()

func remove_effect(avfx_instance: AVFXInstance):
	avfx_instance.queue_free()
	active_effect_count -= 1

	if active_effect_count == 0:
		current_effect_group.queue_free()
		current_effect_group = null
