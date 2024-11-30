extends Label


@export var intro_text: Array[String]
@export var first_post_battle_text: Array[String]
@export var second_post_battle_text: Array[String]

var text_id: int = 0
var current_text: Array[String]
var is_first_fight: bool = true

func _ready():
	Globals.stopped_fighting.connect(_on_globals_stopped_fighting)
	current_text = intro_text

func _process(_delta):
	if not Globals.is_fighting:
		if Input.is_action_just_pressed("button"):
			text_id += 1
			if text_id == len(intro_text):
				into_the_fight()
			else:
				text = intro_text[text_id]

func _on_globals_stopped_fighting():
	visible = true
	text_id = 0
	if is_first_fight:
		is_first_fight = false
		current_text = first_post_battle_text
	else:
		is_first_fight = true
		current_text = second_post_battle_text

func into_the_fight():
	get_parent().get_node("MusicPlayer").start_battle()
	visible = false
