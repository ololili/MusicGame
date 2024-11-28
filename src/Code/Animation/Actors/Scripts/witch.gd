extends Area2D

@export var buildup: float = 0.1
@export var buildup_buildup: float = 0.0
var attack_chance: float = 0.0

var projectile: PackedScene = preload("res://Code/Animation/Actors/enemy_projectile.tscn")
var is_cooling_down: bool = false


func _ready():
	Globals.has_beaten.connect(_on_globals_has_beaten)
	seed(123)

func _on_globals_has_beaten():
	buildup += buildup_buildup
	if not is_cooling_down:
		attack_chance += buildup
	else:
		is_cooling_down = false
	var ran = randf()
	if attack_chance > ran:
		attack()
		attack_chance = 0
		is_cooling_down = true

func attack():
	var node: Node2D = projectile.instantiate()
	
	var spawn_pos: Vector2 = $SpawnPosition.global_position
	spawn_pos.x += randf_range(-10, 10)
	spawn_pos.y += randf_range(-10, 10)
	node.global_position = spawn_pos
	add_sibling(node)
