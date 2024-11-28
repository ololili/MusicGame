extends Area2D

@export var power: Power = null
@export var speed: float = 10

func _ready():
	Globals.has_beaten.connect(_on_globals_has_beaten)

func _process(delta):
	position.x += speed * delta

func start(starting_power: float):
	var quality = Globals.get_beat_synchronization() * starting_power
	power.set_fraction(quality)
	if power.level == 0:
		queue_free()
	else:
		play_animation()

func play_animation():
	$MyAnimationPlayer.play(power.get_level_name() + "_pow")

func _on_globals_has_beaten():
	play_animation()

func _on_area_entered(_area):
	Globals.deal_damage(power.level)
	queue_free()
