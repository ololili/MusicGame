extends Label


func _process(_delta):
	if Input.is_action_just_pressed("button"):
		into_the_fight()


func into_the_fight():
	Globals.start_game()
	queue_free()
