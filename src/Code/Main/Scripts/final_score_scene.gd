extends Sprite2D

var is_responding: bool

func _ready():
	is_responding = false

	var timer: Timer = Timer.new()
	timer.wait_time = 1.0
	timer.timeout.connect(_on_timer_timeout)
	timer.timeout.connect(timer.queue_free)
	add_child(timer)
	timer.start()

func _on_timer_timeout():
	is_responding = true

func _process(_delta):
	if is_responding:
		if Input.is_action_just_released("button"):
			Globals.restart_game()
			queue_free()
