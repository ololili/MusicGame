extends Area2D


@export var power: Power = null
# This value is changed from the animation player
@export var power_fraction: float = 1.0


func _ready():
	$MyAnimationPlayer.start()

func _process(_delta):
	power.set_fraction(power_fraction)


func release():
	$MyAnimationPlayer.speed_scale = $MyAnimationPlayer.speed_scale * 5.8
