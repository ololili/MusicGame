extends Area2D

var buildup: float = 0.1
var big_buildup: float = 0.3
var attack_chance: float = 0.0

var projectile: PackedScene = preload("res://Code/Animation/Actors/enemy_projectile.tscn")
var is_cooling_down: bool = false
var is_fase_boosting: bool = false
var fase_boost: int = 0


func _ready():
	Globals.has_beaten.connect(_on_globals_has_beaten)
	buildup = Globals.difficutly.buildup
	big_buildup = Globals.difficutly.fase_three_buildup

	Globals.started_fase_three.connect(_on_globals_started_fase_three)
	Globals.started_fase_two.connect(_on_globals_started_fase_two)
	Globals.started_fighting.connect(_on_globals_started_fighting)

func _on_globals_has_beaten():
	if Globals.is_fighting:
		if not is_cooling_down:
			attack_chance += buildup if not Globals.is_fase_three else big_buildup
		var ran = randf() + Globals.difficutly.attack_chance_offset
		if not is_fase_boosting:
			if attack_chance > ran:
				var num_attacks = 1
				if Globals.is_fase_three:
					num_attacks += int(randf() * Globals.difficutly.fase_three_boost)
				elif Globals.is_fase_two:
					num_attacks += int(randf() * Globals.difficutly.fase_two_boost)
				attack_sequence(num_attacks)
				attack_chance = 0
				is_cooling_down = true
		else:
			attack_sequence(fase_boost)
			attack_chance = 0
			is_cooling_down = true
			is_fase_boosting = false


func _on_globals_started_fase_two():
	is_fase_boosting = true
	fase_boost = Globals.difficutly.fase_two_boost

func _on_globals_started_fase_three():
	is_fase_boosting = true
	fase_boost = Globals.difficutly.fase_three_boost


func _on_final_timer_timeout():
	is_cooling_down = false

func _on_globals_started_fighting():
	seed(Globals.current_battle_song.resource_name.hash())

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
		timer.timeout.connect(timer.queue_free)
		add_child(timer)
		timer.start()
		
		i += 1
	
		if i == num_attacks:
			timer.timeout.connect(_on_final_timer_timeout)
