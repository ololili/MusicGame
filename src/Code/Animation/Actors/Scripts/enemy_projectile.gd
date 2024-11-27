extends Area2D


@export var power: Power = null
var speed: float = 0
var is_moving: bool = false
var beetle = null

# It is created on a beat and starts to play startup animation right away
# After the second beat, when the startup is finished playing, it should start moving

# If it hits the shield it should decrease in power 
# and the beetle should gain power accordingly

# The projectile should reach the location of the shield in exactly two beats after it starts moving
# Meaning speed should be: distance / (max_time_to_beat * 2)

func _ready():
	$MyAnimationPlayer.play("startup")
	Globals.has_beaten.connect(_on_globals_has_beaten)
	beetle = get_parent().get_node("Beetle")
	set_speed()

func _process(delta):
	if is_moving:
		position.x -= speed * delta


func _on_globals_has_beaten():
	if not is_moving:
		is_moving = true
	play_animation()


func play_animation():
	$MyAnimationPlayer.play(power.get_level_name() + "_pow")

func set_speed():
	var destination = beetle.get_node("ShieldPosition").global_position
	var distance = global_position.distance_to(destination)
	speed = distance / (Globals.max_time_to_beat * 2)

func _on_area_entered(area):
	if area.name == "Beetle":
		Globals.deal_damage(-1 * power.level)
		queue_free()
	else:
		power.change_fraction(-1 * area.power.fraction)
		beetle.add_power(area.power.fraction)
		if power.level == 0:
			queue_free()
		else:
			play_animation()
