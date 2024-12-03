extends TextureProgressBar


func _ready():
	Globals.received_damage.connect(_on_globals_received_damage)
	Globals.stopped_fighting.connect(_on_globals_stopped_fighting)
	Globals.started_fighting.connect(_on_globals_started_figting)

func _on_globals_received_damage(amount: float):
	value += amount
	if value > 100:
		value = 100.0
	elif value <= 0:
		value = 0.0
		Globals.lose_game()

func _on_globals_stopped_fighting():
	Globals.current_battle_song.player = int(value)
	if int(value) > Globals.current_battle_song.player_hi_score:
		Globals.current_battle_song.player_hi_score = int(value)


func _on_globals_started_figting():
	value = 100
