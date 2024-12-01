extends Area2D


var shield: PackedScene = preload("res://Code/Animation/Actors/fast_shield.tscn")
var projectile: PackedScene = preload("res://Code/Animation/Actors/my_projectile.tscn")
var current_shield: Node2D


func _process(_delta):
	if Globals.is_fighting:
		if (Input.is_action_just_pressed("button")
				and not is_instance_valid(current_shield)):
			make_shield()
		if (Input.is_action_just_released("button")
				and is_instance_valid(current_shield)):
			if is_instance_valid(current_shield):
				current_shield.release()


func make_shield():
	current_shield = shield.instantiate()
	current_shield.global_position = $ShieldPosition.global_position
	add_sibling(current_shield)
