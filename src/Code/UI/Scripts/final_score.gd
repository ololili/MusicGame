extends Label


@export var song: Song


func _ready():
	text = str(song.player_hi_score)
	if max(song.mine, song.jan_louw, song.sannie) < song.player_hi_score:
		$Cover.visible = false
