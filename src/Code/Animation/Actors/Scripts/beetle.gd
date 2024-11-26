extends Area2D


var shield: PackedScene = preload("res://Code/Animation/Actors/shield.tscn")
var current_shield: Node2D


func _process(_delta):
	if Input.is_action_just_pressed("button"):
		make_shield(0.1)
	if Input.is_action_just_released("button"):
		if current_shield:
			current_shield.queue_free()

func make_shield(time_offset: float):
	current_shield = shield.instantiate()
	current_shield.global_position = $SpawnPosition.global_position
	current_shield.get_node("MyAnimationPlayer").play("standard")
	add_sibling(current_shield)
