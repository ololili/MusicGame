extends Node2D

@export var difficutly: Difficulty = Difficulty.new()

func _enter_tree():
	Globals.difficutly = difficutly
