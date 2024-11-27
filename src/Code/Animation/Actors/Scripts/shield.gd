extends Area2D


@export var power: Power = null
@export var ease_of_succes: float = 0.1

var animations: MyAnimationPlayer

var is_degrading: bool = false


# When the shield is created it is in between two beats
# At this point it shouldn't be degrading and the animation shouldn't play

# After the first beat the animation should start playing

# After the second beat the power fraction should decrease by 0.01 (a small amount)
# It should now be degrading at a rate of 0.25 every beat


func _ready():
	Globals.has_beaten.connect(_on_globals_has_beaten)

func _process(delta):
	var degradation = delta * -0.25 / Globals.max_time_to_beat
	power.change_fraction(degradation)
	if power.level == 0:
		queue_free()

func start():
	get_power_level()
	is_degrading = false
	
	animations = $MyAnimationPlayer
	animations.play(power.get_level_name() + "_power")
	animations.seek(0.06)
	animations.pause()

func get_power_level():
	var quality = Globals.get_beat_synchronization()
	
	power.set_fraction(quality + ease_of_succes)

	# print(quality, power.get_level_name(), power.level)


func _on_globals_has_beaten():
	if animations.is_playing() and not is_degrading:
		is_degrading = true
		power.change_fraction(-0.01)
	animations.play(power.get_level_name() + "_power")
