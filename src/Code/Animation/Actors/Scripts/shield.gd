extends Area2D


@export var power: Power = null
@export var ease_of_succes: float = 0.1

var animations: MyAnimationPlayer

var is_degrading: bool = false

func _ready():
	Globals.has_beaten.connect(degrade)

func start():
	get_power_level()
	is_degrading = false
	
	animations = $MyAnimationPlayer
	animations.play(power.get_level_name() + "_power")

func get_power_level():
	var time_to_beat = Globals.time_to_beat
	var max_time = Globals.max_time_to_beat
	var quality = max(time_to_beat / max_time, (max_time - time_to_beat) / max_time)
	quality = quality * 2 - 1
	power.level = int(quality * 4 + 1 + ease_of_succes)

	# print(quality, power.get_level_name(), power.level)


func degrade():
	if is_degrading:
		power.level -= 1
	else:
		is_degrading = true
	if power.level == 0:
		queue_free()
	else:
		$MyAnimationPlayer.play(power.get_level_name() + "_power")
