extends Label


func _process(_delta):
	if Input.is_action_just_pressed("button"):
		into_the_fight()


func into_the_fight():
	get_parent().get_node("MusicPlayer").start_battle()
	queue_free()
