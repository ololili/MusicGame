extends Sprite2D


func _ready():
	Globals.has_beaten.connect(start)

func start():
	var anim: AnimationPlayer = $AnimationPlayer
	if not anim.is_playing():
		$AnimationPlayer.play("standard")
