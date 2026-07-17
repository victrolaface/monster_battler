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
	Events.on_ui_ready.emit()
	
func avfx_projectile(instance: AVFXInstance, sprite: Texture2D):
	var sprite_frame = Sprite2D.new()
	add_child(sprite_frame)
	sprite_frame.texture = sprite
	return
