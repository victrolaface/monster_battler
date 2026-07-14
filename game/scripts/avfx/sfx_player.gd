extends AudioStreamPlayer2D

func _ready():
	Events.on_avfx_sfx.connect(play_sfx)
	
func play_sfx(clip: AudioStream, instance: AVFXInstance):
	pitch_scale = randf_range(0.9, 1.1)
	stream = clip
	play()
	finished.connect(instance.finish)
