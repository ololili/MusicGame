extends Area2D

@export var power: Power = null
@export var speed: float = 10

func _ready():
	$MyAnimationPlayer.play(power.get_level_name() + "_pow")

func _process(delta):
	position.x += speed * delta

func start(starting_power: float):
	power.set_fraction(starting_power)


func _on_area_entered(_area):
	Globals.deal_damage(power.level)
	queue_free()
