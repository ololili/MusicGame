extends Node

signal has_beaten
signal new_song_started
signal received_damage(amount: float)

var bpm: int
var time_to_beat: float
var max_time_to_beat: float

func beating():
	has_beaten.emit()

func get_beat_synchronization():
	var synch = max(
		time_to_beat / max_time_to_beat,
		(max_time_to_beat - time_to_beat) / max_time_to_beat)
	synch = synch * 2 - 1
	# quality is first between 1 and 0.5 and then normalised to between 1 and 0
	return synch

func start_new_song(p_bpm: int):
	bpm = p_bpm
	max_time_to_beat = 60.0 / float(bpm)
	new_song_started.emit()

func deal_damage(amount: float):
	received_damage.emit(amount)
