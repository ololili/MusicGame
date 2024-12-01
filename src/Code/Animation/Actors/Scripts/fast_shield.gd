extends Area2D


# The fast shield is always created at max power
# I remains at max power shortly and then quickly degrades
# The animation tells me when it starts to degrade
# It should be killed by the end of the animation one beat in length
# It should time how long it has been alive and then figure out how much longer it lives.

@export var power: Power = null
@export var live_beat_fraction: float = 0.5
@export var power_fraction: float = 1.0
var lifetime: float = 0.0
var is_degrading: bool = false
var degradation: float


func _ready():
	lifetime = 0.0
	is_degrading = false
	$MyAnimationPlayer.start()

func _process(delta):
	power.set_fraction(power_fraction)
	lifetime += delta


func release():
	$MyAnimationPlayer.speed_scale = $MyAnimationPlayer.speed_scale * 3.8
