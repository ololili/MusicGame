extends Area2D


@export var power: Power = null
@export var speed: float = 10
var is_moving: bool = false


func _ready():
	$MyAnimationPlayer.play("startup")
	Globals.has_beaten.connect(start)

func _process(delta):
	if is_moving:
		position.x -= speed * delta


func start():
	is_moving = true
	power.set_fraction(1.0)


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
			$MyAnimationPlayer.play(power.get_level_name() + "_pow")
