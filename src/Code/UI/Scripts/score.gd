extends Label

@export var score_id: int


func _ready():
	text = str(Globals.current_battle_song.get_score_by_id(score_id))
