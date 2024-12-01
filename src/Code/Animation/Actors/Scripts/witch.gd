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
			attack_sequence(int(attack_chance / ran))
			attack_chance = 0
			is_cooling_down = true

func attack_once(spawn_pos):
	var node: Node2D = projectile.instantiate()
	
	
	node.global_position = spawn_pos
	add_sibling(node)

func attack_sequence(num_attacks: int):
	var i = 0
	var spawn_pos: Vector2 = $SpawnPosition.global_position
	var direction: Vector2 = Vector2()
	
	while i < num_attacks:
		direction.x = randf() - 0.5
		direction.y = randf() - 0.5
		direction = direction.normalized()
		spawn_pos = spawn_pos + direction * 10
		spawn_pos.x = min(max(spawn_pos.x, 112), 160)
		spawn_pos.y = min(max(spawn_pos.y, 83), 104)
		var timer = Timer.new()
		timer.wait_time = Globals.max_time_to_beat / 2 * i + 0.01
		timer.timeout.connect(attack_once.bind(spawn_pos))
		timer.connect("timeout", timer.queue_free)
		add_child(timer)
		timer.start()
		
		i += 1
	
	# attack num_attacks number of times
	# 
