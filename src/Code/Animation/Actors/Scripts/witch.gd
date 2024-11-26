extends Area2D


var projectile: PackedScene = preload("res://Code/Animation/Actors/enemy_projectile.tscn")
var is_cooling_down: bool = false


func _ready():
	Globals.has_beaten.connect(attack)

func attack():
	if not is_cooling_down:
		var node: Node2D = projectile.instantiate()
		get_parent().add_child(node)
		node.global_position = $SpawnPosition.global_position
		is_cooling_down = true
	else:
		is_cooling_down = false
