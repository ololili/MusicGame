extends Node2D

var progress: float = 0.0


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


func _process(delta):

	if is_responding:
		if Input.is_action_pressed("button"):
			progress += delta * 100
			$MyProgressBar.value = progress
		if progress > 100:
			Globals.move_to_previous_song()
			queue_free()
		if Input.is_action_just_released("button"):
			Globals.move_to_next_song()
			queue_free()
