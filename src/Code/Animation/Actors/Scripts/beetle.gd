extends Area2D


@export var power: Power = null

var shield: PackedScene = preload("res://Code/Animation/Actors/shield.tscn")
var projectile: PackedScene = preload("res://Code/Animation/Actors/my_projectile.tscn")
var current_shield: Node2D
var is_attacking: bool = false


func _ready():
	power.level = 0
	Globals.has_beaten.connect(_on_globals_has_beaten)

func _process(_delta):
	if not is_attacking:
		if Input.is_action_just_pressed("button"):
			make_shield()
		if Input.is_action_just_released("button"):
			if is_instance_valid(current_shield):
				current_shield.queue_free()
				is_attacking = true

func attack():
	var node: Node2D = projectile.instantiate()
	node.start(power.level)
	node.global_position = $AttackPosition.global_position
	power.level = 0
	add_sibling(node)


func add_power(new_power: int):
	power.level += new_power
	if power.level > 5:
		power.level = 5

func make_shield():
	current_shield = shield.instantiate()
	current_shield.global_position = $ShieldPosition.global_position
	current_shield.start()
	add_sibling(current_shield)

func _on_globals_has_beaten():
	if is_attacking:
		attack();
		is_attacking = false
	else:
		$MyAnimationPlayer.play(power.get_level_name() + "_pow")
