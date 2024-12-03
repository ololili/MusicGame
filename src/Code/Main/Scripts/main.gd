extends Node2D

@export var difficutly: Difficulty = Difficulty.new()

var level: PackedScene = preload("res://Code/Main/level.tscn")
var score_scene: PackedScene = preload("res://Code/Main/score_scene.tscn")
var score_node: Node2D

func _enter_tree():
	Globals.difficutly = difficutly

func _ready():
	Globals.stopped_fighting.connect(_on_globals_stopped_fighting)


func _on_globals_stopped_fighting():
	score_node = score_scene.instantiate()
	add_child(score_node)
