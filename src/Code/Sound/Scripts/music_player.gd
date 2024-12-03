extends AudioStreamPlayer

@export_group("volume")
@export var music_volume: float
@export var effects_volume: float
@export_group("songs")
@export var intro_song: Song
@export var battle_songs: Array[Song]

var current_song: Song
var current_battle_song: Song

# This is incremented before every use
# It needs to start at -1 to start at 0
var battle_song_id: int = -1

var bpm: int
var max_time_to_beat: float
var time_to_beat: float

var has_started: bool = false

# It should start at the intro song which will be looped forever.
# If there is an external call it should go into battle songs.
# At the end of a battle song it should loop back to the intro song.
# If the external call is sounded again it should kick into the next battle song.

func _ready():
	var timer = Timer.new()
	timer.wait_time = 0.1
	timer.timeout.connect(start_intro)
	timer.timeout.connect(timer.queue_free)
	add_child(timer)
	timer.start()

	Globals.started_game.connect(next_battle)
	Globals.moved_to_next_song.connect(next_battle)
	Globals.moved_to_previous_song.connect(previous_battle)
	Globals.lost_game.connect(end_battle)

func _process(delta):
	if has_started:
		if playing:
			handle_beating(delta)
		elif current_song == intro_song:
			play()
		elif current_song == current_battle_song:
			end_battle()
			

func start_intro():
	swap_to_song(intro_song)
	has_started = true

func end_battle():
	swap_to_song(intro_song)
	Globals.stop_fighting()

func next_battle():
	battle_song_id += 1
	if battle_song_id == len(battle_songs):
		battle_song_id = -1
		Globals.end_game()
		return null
	
	current_battle_song = battle_songs[battle_song_id]
	Globals.current_battle_song = current_battle_song
	swap_to_song(current_battle_song)
	Globals.start_fighting()

func previous_battle():
	swap_to_song(current_battle_song)
	Globals.start_fighting()

func handle_beating(delta):
	time_to_beat -= delta
	if time_to_beat < 0:
		Globals.beating()
		time_to_beat += max_time_to_beat
	Globals.time_to_beat = time_to_beat

func swap_to_song(song: Song):
	current_song = song
	stream = song.audio
	bpm = int(song.audio.bpm)
	Globals.start_new_song(bpm)
	max_time_to_beat = 60.0 / float(bpm)
	time_to_beat = max_time_to_beat
	play()
	set_fases(song)

func set_fases(song: Song):
	if song.has_fase_two:
		var timer = Timer.new()
		timer.wait_time = song.time_to_fase_two
		timer.timeout.connect(Globals.start_fase_two)
		timer.timeout.connect(timer.queue_free)
		add_child(timer)
		timer.start()
	
	if song.has_fase_three:
		var timer = Timer.new()
		timer.wait_time = song.time_to_fase_three
		timer.timeout.connect(Globals.start_fase_three)
		timer.timeout.connect(timer.queue_free)
		add_child(timer)
		timer.start()

func _on_globals_moved_to_next_song():
	next_battle()

func _on_globals_moved_to_previous_song():
	previous_battle()
