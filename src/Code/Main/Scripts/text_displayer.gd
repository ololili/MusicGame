extends Label


func _ready():
	Globals.restarted_game.connect(_on_globals_restarted_game)


func _process(_delta):
	if visible:
		if Input.is_action_just_pressed("button"):
			into_the_fight()


func into_the_fight():
	Globals.start_game()
	visible = false

func _on_globals_restarted_game():
	visible = true
