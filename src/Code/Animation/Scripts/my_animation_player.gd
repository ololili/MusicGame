extends AnimationPlayer

class_name MyAnimationPlayer


func _ready():
	Globals.has_beaten.connect(start)
	Globals.new_song_started.connect(stop)


func start():
	if not is_playing():
		speed_scale = float(Globals.bpm) / 100.0
		play("standard")
