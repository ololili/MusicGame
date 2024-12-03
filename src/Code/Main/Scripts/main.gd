extends Node2D

@export var difficutly: Difficulty = Difficulty.new()

var score_scene: PackedScene = preload("res://Code/Main/score_scene.tscn")
var final_score_scene: PackedScene = preload("res://Code/Main/final_score_scene.tscn")
var score_node: Node2D

func _enter_tree():
	Globals.difficutly = difficutly

func _ready():
	Globals.stopped_fighting.connect(_on_globals_stopped_fighting)
	Globals.ended_game.connect(_on_globals_ended_game)


func _on_globals_ended_game():
	var node: Node2D = final_score_scene.instantiate()
	add_child(node)

func _on_globals_stopped_fighting():
	score_node = score_scene.instantiate()
	add_child(score_node)
