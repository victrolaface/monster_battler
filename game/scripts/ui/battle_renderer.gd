extends Control

@export var enemy_mon_module: MonsterRendererModule
@export var player_mon_module: MonsterRendererModule
@export var enemy_mon_state_dump: MonsterDataDump
@export var player_mon_state_dump: MonsterDataDump
		
func _ready():
	enemy_mon_module.connect_events()
	player_mon_module.connect_events()
	enemy_mon_state_dump.connect_events()
	player_mon_state_dump.connect_events()
	
	Events.on_avfx_projectile.connect(avfx_projectile)
	Events.on_avfx_animation.connect(avfx_animation)
	
	Events.on_ui_ready.emit()
	
func avfx_projectile(instance: AVFXInstance, texture: Texture2D):
	if instance.resource.delay == 0:
		do_avfx_projectile(instance, texture)
	else:
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = instance.resource.delay
		timer.one_shot = true
		timer.timeout.connect(func(): do_avfx_projectile(instance, texture))
		timer.start()
		return

func do_avfx_projectile(instance: AVFXInstance, texture: Texture2D):
	var sprite = Sprite2D.new()
	add_child(sprite)
	sprite.texture = texture
	
	sprite.global_position = get_monster_frame(instance.target if instance.target_self else instance.user).global_position
	sprite.offset = instance.resource.offset
	
	var tween = get_tree().create_tween()
	
	tween.tween_property(sprite, "global_position", enemy_mon_module.frame.global_position, instance.resource.duration)\
		.set_delay(instance.resource.delay)
	tween.tween_callback(func(): cleanup_avfx_node(instance, sprite))

func avfx_animation(instance: AVFXInstance, animation_scene: PackedScene):
	if instance.resource.delay == 0:
		do_avfx_animation(instance, animation_scene)
	else:
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = instance.resource.delay
		timer.one_shot = true
		timer.timeout.connect(func(): do_avfx_animation(instance, animation_scene))
		timer.start()
		
func do_avfx_animation(instance: AVFXInstance, animation_scene: PackedScene):
	var animation_node: AnimatedSprite2D = animation_scene.instantiate()
	add_child(animation_node)
	animation_node.global_position = enemy_mon_module.frame.global_position
	animation_node.sprite_frames.set_animation_loop("default", false)
	animation_node.offset = instance.resource.offset
	animation_node.play()
	animation_node.animation_finished.connect(func(): cleanup_avfx_node(instance, animation_node))

func get_monster_frame(monster: Monster):
	if enemy_mon_module.bound_monster == monster:
		return enemy_mon_module.frame
	if player_mon_module.bound_monster == monster:
		return player_mon_module.frame
	return null
		

func cleanup_avfx_node(instance, sprite):
	sprite.queue_free()
	instance.finish()
