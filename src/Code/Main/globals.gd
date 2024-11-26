extends Node

signal has_beaten
signal new_song_started
signal received_damage(amount: float)

var bpm: int
var time_to_beat: float


func beating():
	has_beaten.emit()

func start_new_song(p_bpm: int):
	bpm = p_bpm
	new_song_started.emit()

func deal_damage(amount: float):
	received_damage.emit(amount)
