extends AudioStreamPlayer

@export_group("volume")
@export var music_volume: float
@export var effects_volume: float
@export_group("songs")
@export var intro_song: Song
@export var battle_songs: Array[Song]

var battle_song_id: int = 0

var bpm: int
var max_time_to_beat: float
var time_to_beat: float

var is_playing_intro: bool = true

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

func _process(delta):
	
	if playing:
		handle_beating(delta)
	else:
		start_intro()
			
func start_battle():
	swap_to_song(battle_songs[battle_song_id])
	Globals.start_fighting()
	battle_song_id += 1
	battle_song_id = battle_song_id % len(battle_songs)


func start_intro():
	swap_to_song(intro_song)
	Globals.stop_fighting()


func handle_beating(delta):
	time_to_beat -= delta
	if time_to_beat < 0:
		Globals.beating()
		time_to_beat += max_time_to_beat
	Globals.time_to_beat = time_to_beat

func swap_to_song(song: Song):
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
