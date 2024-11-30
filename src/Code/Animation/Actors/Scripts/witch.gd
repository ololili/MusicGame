extends Area2D

@export var buildup: float = 0.1
var attack_chance: float = 0.0

var projectile: PackedScene = preload("res://Code/Animation/Actors/enemy_projectile.tscn")
var is_cooling_down: bool = false

# Every beat attack chance increases by buildup.
# Then if random number ran, between 0 and 1, is less than attack chance, an attack happens
# If it is fase one always a single attack and then chance is reset to 0

# If it is fase two attack (attack_chance / ran) number of times.
# The attacks should spawn one half of a beat appart
# They should all spawn in a straight line, that is pointing in a random direction

func _ready():
	Globals.has_beaten.connect(_on_globals_has_beaten)
	seed(123)

func _on_globals_has_beaten():
	if Globals.is_fighting:
		if not is_cooling_down:
			attack_chance += buildup
		else:
			is_cooling_down = false
		var ran = randf()
		if attack_chance > ran:
			attack_once()
			attack_chance = 0
			is_cooling_down = true

func attack_once():
	var node: Node2D = projectile.instantiate()
	
	var spawn_pos: Vector2 = $SpawnPosition.global_position
	spawn_pos.x += randf_range(-10, 10)
	spawn_pos.y += randf_range(-10, 10)
	node.global_position = spawn_pos
	add_sibling(node)
