extends Area2D


@export var power: Power = null
@export var cooldown_fraction: float = 0.5

var shield: PackedScene = preload("res://Code/Animation/Actors/shield.tscn")
var projectile: PackedScene = preload("res://Code/Animation/Actors/my_projectile.tscn")
var current_shield: Node2D
var cooldown: float = 0.0
var max_cooldown: float = 0.0


func _ready():
	power.set_fraction(0.0)
	Globals.has_beaten.connect(_on_globals_has_beaten)

func _process(delta):
	if cooldown > 0:
		cooldown -= delta
	else:
		if Input.is_action_just_pressed("button"):
			make_shield()
		if Input.is_action_just_released("button"):
			attack()
			if is_instance_valid(current_shield):
				current_shield.queue_free()

func attack():
	var node: Node2D = projectile.instantiate()
	node.global_position = $AttackPosition.global_position
	add_sibling(node)
	node.start(power.fraction)

	power.set_fraction(0.0)
	cooldown = max_cooldown


func add_power(power_change: float):
	power.change_fraction(power_change)

func make_shield():
	current_shield = shield.instantiate()
	current_shield.global_position = $ShieldPosition.global_position
	add_sibling(current_shield)
	current_shield.start()


func play_animation():
	var animations: MyAnimationPlayer = $MyAnimationPlayer
	animations.play(power.get_level_name() + "_pow")

func set_max_cooldown():
	max_cooldown = cooldown_fraction * Globals.max_time_to_beat

func _on_globals_has_beaten():
	play_animation()
