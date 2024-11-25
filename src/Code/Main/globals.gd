extends Node

signal has_beaten
signal new_song_started(bpm: int)

var bpm: int


func beating():
	has_beaten.emit()

func start_new_song(p_bpm: int):
	bpm = p_bpm
	new_song_started.emit(bpm)
