extends Area2D


# The fast shield is always created at max power
# I remains at max power shortly and then quickly degrades
# The animation tells me when it starts to degrade
# It should be killed by the end of the animation one beat in length
# It should time how long it has been alive and then figure out how much longer it lives.

@export var power: Power = null
var lifetime: float = 0.0
var is_degrading: bool = false
var degradation: float


func _ready():
	power.set_fraction(1.0)
	lifetime = 0.0
	is_degrading = false
	$MyAnimationPlayer.start()

func _process(delta):
	lifetime += delta
	if is_degrading:
		power.change_fraction(-1 * degradation * delta)
		if power.level == 0:
			queue_free()


func start_degrading():
	is_degrading = true
	var remaining_life = Globals.max_time_to_beat - lifetime
	degradation = 1 / remaining_life
