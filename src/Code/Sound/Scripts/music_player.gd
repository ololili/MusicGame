extends AudioStreamPlayer

@export_group("volume")
@export var music_volume: float
@export var effects_volume: float
@export_group("songs")
@export var intro_song: AudioStream
@export var battle_songs: Array[AudioStream]

var bpm: int
var max_time_to_beat: float
var time_to_beat: float

var is_first_song: bool = true


func _process(delta):
	if playing:
		time_to_beat -= delta
		if time_to_beat < 0:
			Globals.beating()
			time_to_beat += max_time_to_beat
		Globals.time_to_beat = time_to_beat
	else:
		if is_first_song:
			swap_to_song(intro_song)
			is_first_song = false
		else:
			swap_to_song(battle_songs[0])
			is_first_song = true
		play()
		time_to_beat = max_time_to_beat


func swap_to_song(song: AudioStream):
	stream = song
	bpm = song.bpm
	Globals.start_new_song(bpm)
	max_time_to_beat = 60.0 / float(bpm)
