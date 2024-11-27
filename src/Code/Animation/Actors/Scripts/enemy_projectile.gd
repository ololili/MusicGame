extends Area2D


@export var power: Power = null
@export var speed: float = 10
var is_moving: bool = false

# It is created on a beat and starts to play startup animation right away
# After the second beat, when the startup is finished playing, it should start moving

# If it hits the shield it should decrease in power 
# and the beetle should gain power accordingly

func _ready():
	$MyAnimationPlayer.play("startup")
	Globals.has_beaten.connect(_on_globals_has_beaten)

func _process(delta):
	if is_moving:
		position.x -= speed * delta


func _on_globals_has_beaten():
	if not is_moving:
		is_moving = true
	play_animation()
	

func play_animation():
	$MyAnimationPlayer.play(power.get_level_name() + "_pow")


func _on_area_entered(area):
	if area.name == "Beetle":
		Globals.deal_damage(-1 * power.level)
		queue_free()
	else:
		power.change_fraction(-1 * area.power.fraction)
		get_parent().get_node("Beetle").add_power(area.power.fraction)
		if power.level == 0:
			queue_free()
		else:
			play_animation()
