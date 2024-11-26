extends AnimationPlayer

class_name MyAnimationPlayer


func _ready():
	Globals.has_beaten.connect(start)
	Globals.new_song_started.connect(restart)


func start():
	if not is_playing():
		speed_scale = float(Globals.bpm) / 100.0
		play("standard")

func restart():
	stop()
	start()
