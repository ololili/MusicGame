extends AnimationPlayer

class_name MyAnimationPlayer

@export var has_one_animation: bool = true

func _ready():
	set_speed()
	if has_one_animation:
		Globals.new_song_started.connect(start)


func start():
	set_speed()
	play("standard")

func set_speed():
	speed_scale = float(Globals.bpm) / 100.0
