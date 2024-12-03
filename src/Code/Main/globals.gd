extends Node


signal received_damage(amount: float)

# These signals are called from music player
signal has_beaten
signal new_song_started
signal stopped_fighting
signal started_fighting
signal started_fase_two
signal started_fase_three

# These signals are called from text displayer or score scene
signal moved_to_next_song
signal moved_to_previous_song
signal started_game

# This signal is called from health bar when the hp runs out
signal lost_game


var bpm: int
var time_to_beat: float
var max_time_to_beat: float

var is_fighting: bool = false
var is_fase_two: bool = false
var is_fase_three: bool = false

var difficutly: Difficulty

# Contains the battle song that is currently playing
# Unless the intro is playing in which case it contains the last one
var current_battle_song: Song


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
	is_fase_two = false
	is_fase_three = false
	new_song_started.emit()

func deal_damage(amount: float):
	received_damage.emit(amount)

func start_fase_two():
	is_fase_two = true
	started_fase_two.emit()

func start_fase_three():
	is_fase_three = true
	started_fase_three.emit()

func start_fighting():
	is_fighting = true
	started_fighting.emit()

func stop_fighting():
	is_fighting = false
	stopped_fighting.emit()


func move_to_next_song():
	moved_to_next_song.emit()

func move_to_previous_song():
	moved_to_previous_song.emit()

func start_game():
	started_game.emit()

func lose_game():
	lost_game.emit()
