extends Resource
class_name Song

@export var audio: AudioStreamOggVorbis = null

@export_group("Fases")
@export var has_fase_two: bool = false
@export var time_to_fase_two: float = 0.0

@export var has_fase_three: bool = false
@export var time_to_fase_three: float = 0.0

@export_group("Scores")
@export var mine: float = 0
@export var jan_louw: float = 0
@export var sannie: float = 0
@export var player_hi_score: float = 0
@export var player: float = 0

func get_score_by_id(score_id: int):
	if score_id == 0:
		return mine
	if score_id == 1:
		return jan_louw
	if score_id == 2:
		return sannie
	if score_id == 3:
		return player_hi_score
	if score_id == 4:
		return player
